import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_hood/app/controllers/controllers.dart';
import 'package:pet_hood/app/controllers/external_profile_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/pages/home/home_page_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/entities.dart';
import 'package:pet_hood/database/api_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class ApiController {
  final ApiAdapter _apiAdapter = Get.find();
  final UserController _userController = Get.find();
  final PetDetailsController _petDetailsController = Get.find();
  final AdoptionController _adoptionController = Get.find();
  final FeedController _feedController = Get.find();
  final ExternalProfileController _externalProfileController = Get.find();
  final PublicationPageController _publicationPageController = Get.find();
  final HomePageController _homePageController = Get.put(HomePageController());

  final Options options = Options(
    headers: {
      "requiresToken": true,
    },
  );

  void showSnackbar(DioError e) {
    var errorSplit = e.response.toString().split(":");
    Get.snackbar(
      "Ocorreu um erro",
      errorSplit[errorSplit.length - 1]
          .replaceAll("\"", "")
          .replaceAll("}", ""),
      duration: const Duration(
        seconds: 2,
      ),
      backgroundColor: primary,
      colorText: base,
    );
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('email');
    prefs.remove('password');

    _userController.clear();
    _petDetailsController.clear();
    _adoptionController.clear();
    _feedController.clear();
    _externalProfileController.clear();
    _homePageController.clear();

    return true;
  }

  Future<bool> loginAttempt(String email, String password) async {
    try {
      var response = await _apiAdapter.post(
        '/sessions',
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {
            "requiresToken": false,
          },
        ),
      );

      UserEntity userEntity = UserEntity(
        id: response.data['user']['id'],
        email: response.data['user']['email'],
        name: response.data['user']['name'],
        userName: response.data['user']['user_name'],
        profileImage: response.data['user']['profile_image'],
        backgroundImage: response.data['user']['background_image'],
        bio: response.data['user']['bio'],
      );

      _userController.userEntity = userEntity;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.data['token']);
      prefs.setString('email', email);
      prefs.setString('password', password);

      await fetchAllUserInfo();

      Get.offAllNamed("/");

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  fetchAllUserInfo() async {
    _feedController.loadingFeed = true;
    await getFeedPosts();
    _feedController.loadingFeed = false;
    await getProfilePets();
    await getNewPets();
    await getPostsByUserId(userId: _userController.userEntity.id);
  }

  Future<bool> getFeedPosts({
    int? page = 0,
  }) async {
    try {
      var response = await _apiAdapter.get(
        "/posts?page=$page",
        options: options,
      );

      List<PostEntity> postList = response.data != null
          ? response.data['data']
              .map<PostEntity>((post) => PostEntity(
                    id: post['id'],
                    userId: post['user']['id'],
                    name: post['user']['name'],
                    avatar: post['user']['profile_image'] ?? '',
                    username: post['user']['user_name'],
                    isOwner:
                        post['user']['id'] == _userController.userEntity.id,
                    postedAt: DateTime.parse(post['created_at']),
                    isLiked: post['post_likes'].firstWhere(
                          (item) =>
                              item['user_id'] == _userController.userEntity.id,
                          orElse: () => null,
                        ) !=
                        null,
                    qtLikes: post['post_likes'].length,
                    pet: PetEntity(
                      userId: _userController.userEntity.id,
                      breed: post['pet']['breed'],
                      age: post['pet']['age'],
                      yearOrMonth: YearOrMonth.values.firstWhere(
                          (item) => item.name == post['pet']['year_or_month']),
                      vaccine: post['pet']['vaccine'] ?? false,
                      id: post['pet']['id'],
                      name: post['pet']['name'],
                      description: post['pet']['bio'] ?? '',
                      createdAt: DateTime.parse(post['pet']['created_at']),
                      category: PetCategory.values.firstWhere(
                          (item) => item.name == post['pet']['pet_category']),
                      state: post['pet']['state'] ?? '',
                      city: post['pet']['city'] ?? '',
                      petImage: post['pet']['pet_image'],
                      petOwnerName: post['user']['name'],
                      petOwnerImage: post['user']['profile_image'] ?? '',
                      postId: post['id'],
                    ),
                  ))
              .toList()
          : [];

      if (page == 0) {
        _feedController.listPosts = [...postList];
        validatePostListLength(postList.length);
      } else {
        _feedController.listPosts = [..._feedController.listPosts, ...postList];
        validatePostListLength(postList.length);
      }
      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }
    return false;
  }

  validatePostListLength(int size) {
    if (size < 10) {
      _feedController.maxPostsReached = true;
    } else {
      _feedController.page += 1;
      _feedController.maxPostsReached = false;
    }
  }

  Future<bool> getProfilePets() async {
    try {
      var response = await _apiAdapter.get(
        "/pets",
        options: options,
      );

      List<PetEntity> petList = response.data != null
          ? response.data
              .map<PetEntity>((profilePet) => PetEntity(
                    id: profilePet['id'],
                    userId: profilePet['user_id'],
                    name: profilePet['name'],
                    breed: profilePet['breed'],
                    vaccine: profilePet['vaccine'],
                    petImage: profilePet['pet_image'],
                    description: profilePet['bio'],
                    age: profilePet['age'],
                    state: profilePet['state'],
                    city: profilePet['city'],
                    yearOrMonth: YearOrMonth.values.firstWhere((element) =>
                        element.name == profilePet['year_or_month']),
                    category: PetCategory.values.firstWhere((element) =>
                        element.name == profilePet['pet_category']),
                    createdAt: DateTime.parse(profilePet['created_at']),
                    petOwnerName: _userController.userEntity.name,
                    petOwnerImage: _userController.userEntity.profileImage,
                  ))
              .toList()
          : [];

      _userController.petList = petList
          .where((element) => element.category == PetCategory.profile)
          .toList();

      _userController.adoptionPetList = petList
          .where((element) => element.category == PetCategory.adoption)
          .toList();

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> getNewPets() async {
    try {
      var response = await _apiAdapter.get(
        '/pets/new-pets',
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );

      List<PetEntity> petList = response.data != null
          ? response.data
              .map<PetEntity>(
                (pet) => PetEntity(
                  id: pet['id'],
                  userId: pet['user_id'],
                  breed: pet['breed'] ?? '',
                  age: pet['age'],
                  name: pet['name'] ?? '',
                  petImage: pet['pet_image'] ?? '',
                  vaccine: pet['vaccine'] ?? false,
                  yearOrMonth: YearOrMonth.values.firstWhere((yearOrMonth) =>
                      yearOrMonth.name == pet['year_or_month']),
                  description: pet['bio'] ?? '',
                  city: pet['city'],
                  state: pet['state'],
                  category: PetCategory.values.firstWhere(
                      (category) => category.name == pet['pet_category']),
                  createdAt: DateTime.parse(pet['created_at']),
                  petOwnerName: pet['user']['name'] ?? '',
                  petOwnerImage: pet['user']['profile_image'] ?? '',
                ),
              )
              .toList()
          : [];

      _adoptionController.petList = petList;

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<void> fetchExternalUserInfo(String userId) async {
    await getPostsByUserId(userId: userId);
    await getUserById(userId: userId);
    await getProfilePetsByUserId(userId: userId);
  }

  Future<bool> getPostsByUserId({
    int? page = 0,
    required String userId,
  }) async {
    try {
      var response = await _apiAdapter.get(
        "/posts/$userId?page=$page",
        options: options,
      );

      List<PostEntity> postList = response.data != null
          ? response.data['data']
              .map<PostEntity>((post) => PostEntity(
                    id: post['id'],
                    userId: post['user']['id'],
                    name: post['user']['name'],
                    avatar: post['user']['profile_image'] ?? '',
                    username: post['user']['user_name'],
                    isOwner:
                        post['user']['id'] == _userController.userEntity.id,
                    postedAt: DateTime.parse(post['created_at']),
                    isLiked: post['post_likes'].firstWhere(
                          (item) =>
                              item['user_id'] == _userController.userEntity.id,
                          orElse: () => null,
                        ) !=
                        null,
                    qtLikes: post['post_likes'].length,
                    pet: PetEntity(
                      userId: _userController.userEntity.id,
                      breed: post['pet']['breed'],
                      age: post['pet']['age'],
                      yearOrMonth: YearOrMonth.values.firstWhere(
                          (item) => item.name == post['pet']['year_or_month']),
                      vaccine: post['pet']['vaccine'] ?? false,
                      id: post['pet']['id'],
                      name: post['pet']['name'],
                      description: post['pet']['bio'] ?? '',
                      createdAt: DateTime.parse(post['pet']['created_at']),
                      category: PetCategory.values.firstWhere(
                          (item) => item.name == post['pet']['pet_category']),
                      state: post['pet']['state'] ?? '',
                      city: post['pet']['city'] ?? '',
                      petImage: post['pet']['pet_image'],
                      petOwnerName: post['user']['name'],
                      petOwnerImage: post['user']['profile_image'] ?? '',
                      postId: post['id'],
                    ),
                  ))
              .toList()
          : [];

      if (page == 0) {
        if (userId == _userController.userEntity.id) {
          _userController.postList = [...postList];
          validatePostListLengthUserController(postList.length);
        } else {
          _externalProfileController.postList = [...postList];
          validatePostListLengthExternalUserController(postList.length);
        }
      } else {
        if (userId == _userController.userEntity.id) {
          _userController.postList = [..._userController.postList, ...postList];
          validatePostListLengthUserController(postList.length);
        } else {
          _externalProfileController.postList = [
            ..._externalProfileController.postList,
            ...postList
          ];
          validatePostListLengthExternalUserController(postList.length);
        }
      }

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  validatePostListLengthUserController(int size) {
    if (size < 10) {
      _userController.maxPostsReached = true;
    } else {
      _userController.page += 1;
    }
  }

  validatePostListLengthExternalUserController(int size) {
    if (size < 10) {
      _externalProfileController.maxPostsReached = true;
    } else {
      _externalProfileController.page += 1;
    }
  }

  Future<bool> getProfilePetsByUserId({
    required String userId,
  }) async {
    try {
      var response = await _apiAdapter.get(
        "/pets/$userId",
        options: options,
      );

      List<PetEntity> petList = response.data != null
          ? response.data
              .map<PetEntity>((profilePet) => PetEntity(
                    id: profilePet['id'],
                    userId: profilePet['user_id'],
                    name: profilePet['name'],
                    breed: profilePet['breed'],
                    vaccine: profilePet['vaccine'],
                    petImage: profilePet['pet_image'],
                    description: profilePet['bio'],
                    age: profilePet['age'],
                    state: profilePet['state'],
                    city: profilePet['city'],
                    yearOrMonth: YearOrMonth.values.firstWhere((element) =>
                        element.name == profilePet['year_or_month']),
                    category: PetCategory.values.firstWhere((element) =>
                        element.name == profilePet['pet_category']),
                    createdAt: DateTime.parse(profilePet['created_at']),
                    petOwnerName:
                        _externalProfileController.externalUserEntity.name,
                    petOwnerImage: _externalProfileController
                        .externalUserEntity.profileImage,
                  ))
              .toList()
          : [];

      _externalProfileController.petList = petList
          .where((element) => element.category == PetCategory.profile)
          .toList();

      _externalProfileController.adoptionPetList = petList
          .where((element) => element.category == PetCategory.adoption)
          .toList();

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> updateUserInfo({
    required String email,
    required String username,
    required String bio,
  }) async {
    try {
      await _apiAdapter.put(
        '/users',
        data: {
          "id": _userController.userEntity.id,
          "email": email,
          "user_name": username,
          "bio": bio,
        },
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );

      UserEntity _userEntity = _userController.userEntity;

      _userEntity.email = email;
      _userEntity.userName = username;
      _userEntity.bio = bio;

      _userController.userEntity = _userEntity;

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> updateProfileImage(XFile image) async {
    _userController.loadingProfileImage = true;
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType('image', 'png'),
        )
      });
      var imagePath = await _apiAdapter.post(
        "/uploads",
        data: formData,
        options: Options(
          headers: {
            "requiresToken": true,
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      await _apiAdapter.put(
        "/users/profileImage",
        data: {
          'id': _userController.userEntity.id,
          'profile_image': imagePath.data,
        },
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );

      _userController.userEntity.profileImage = imagePath.data;
      _userController.loadingProfileImage = false;
      return true;
    } on DioError catch (e) {
      _userController.loadingProfileImage = false;
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> updateBackgroundImage(XFile image) async {
    _userController.loadingBackgroundImage = true;
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType('image', 'png'),
        )
      });
      var imagePath = await _apiAdapter.post(
        "/uploads",
        data: formData,
        options: Options(
          headers: {
            "requiresToken": true,
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      await _apiAdapter.put(
        "/users/backgroundImage",
        data: {
          'id': _userController.userEntity.id,
          'background_image': imagePath.data,
        },
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );

      _userController.userEntity.backgroundImage = imagePath.data;
      _userController.loadingBackgroundImage = false;
      return true;
    } on DioError catch (e) {
      _userController.loadingBackgroundImage = false;
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> saveProfilePet({
    required String breed,
    required String petName,
    required int? age,
    required bool vaccine,
    required YearOrMonth yearOrMonth,
    required String description,
    required String state,
    required String city,
    required File petImage,
    required PetCategory petCategory,
  }) async {
    try {
      String fileName = petImage.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          petImage.path,
          filename: fileName,
          contentType: MediaType('image', 'png'),
        )
      });

      var imagePath = await _apiAdapter.post(
        "/uploads",
        data: formData,
        options: Options(
          headers: {
            "requiresToken": true,
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      var response = await _apiAdapter.post(
        "/pets",
        data: {
          "breed": breed,
          "name": petName,
          "age": age,
          "vaccine": vaccine,
          "pet_image": imagePath.data,
          "year_or_month": yearOrMonth.name,
          "bio": description,
          "state": state,
          "city": city,
          "pet_category": 'profile',
        },
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );

      final UserEntity user = _userController.userEntity;

      final PetEntity petEntity = PetEntity(
        id: response.data['id'],
        userId: _userController.userEntity.id,
        breed: breed,
        age: age,
        yearOrMonth:
            YearOrMonth.values.firstWhere((element) => element == yearOrMonth),
        vaccine: vaccine,
        name: petName,
        description: description,
        category: petCategory,
        petImage: imagePath.data,
        state: state,
        city: city,
        petOwnerName: user.name,
        petOwnerImage: user.profileImage,
        createdAt: DateTime.parse(response.data['created_at']),
      );

      _userController.addNewPet(petEntity);
      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> updateProfilePet({
    required String id,
    required String breed,
    required String petName,
    required int? age,
    required bool vaccine,
    required YearOrMonth yearOrMonth,
    required String description,
    required String state,
    required String city,
    required File petImage,
    required PetCategory petCategory,
  }) async {
    _petDetailsController.loadingPublication = true;
    try {
      dynamic imagePath;
      if (petImage.path.isNotEmpty) {
        String fileName = petImage.path.split('/').last;
        FormData formData = FormData.fromMap({
          "image": await MultipartFile.fromFile(
            petImage.path,
            filename: fileName,
            contentType: MediaType('image', 'png'),
          )
        });
        if (petImage.path.isNotEmpty) {
          imagePath = await _apiAdapter.post(
            "/uploads",
            data: formData,
            options: Options(
              headers: {
                "requiresToken": true,
                "Content-Type": "multipart/form-data",
              },
            ),
          );
        }
      }

      var response = await _apiAdapter.put(
        "/pets",
        data: {
          "id": id,
          "breed": breed,
          "name": petName,
          "age": age,
          "vaccine": vaccine,
          "pet_image": petImage.path.isNotEmpty
              ? imagePath.data
              : _petDetailsController.petDetail.petImage,
          "year_or_month": yearOrMonth.name,
          "bio": description,
          "state": state,
          "city": city,
          "pet_category": 'profile',
        },
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );

      final UserEntity user = _userController.userEntity;

      final PetEntity petEntity = PetEntity(
        id: response.data['id'],
        userId: _userController.userEntity.id,
        breed: breed,
        age: age,
        yearOrMonth:
            YearOrMonth.values.firstWhere((element) => element == yearOrMonth),
        vaccine: vaccine,
        name: petName,
        description: description,
        category: petCategory,
        petImage: petImage.path.isNotEmpty
            ? imagePath.data
            : _petDetailsController.petDetail.petImage,
        state: state,
        city: city,
        petOwnerName: user.name,
        petOwnerImage: user.profileImage,
        createdAt: _petDetailsController.petDetail.createdAt,
      );

      // if (petEntity.category == PetCategory.adoption) {
      //   _feedController.updatePostById(petEntity.postId!, petEntity);
      //   _userController.updatePostById(petEntity.postId!, petEntity);
      //   _userController.updateAdoptionPet(petEntity);
      //   _adoptionController.updatePet(petEntity);
      // } else {
      _userController.updatePet(petEntity);
      _petDetailsController.petDetail = petEntity;
      // }

      _petDetailsController.loadingPublication = false;
      return true;
    } on DioError catch (e) {
      _petDetailsController.loadingPublication = false;
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> removePet(String id) async {
    try {
      await _apiAdapter.delete(
        "/pets/$id",
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );
      _userController.removePet(_petDetailsController.petDetail);
      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<Map<String, dynamic>> savePet({
    required String breed,
    required String petName,
    required int? age,
    required bool vaccine,
    required YearOrMonth yearOrMonth,
    required String description,
    required String state,
    required String city,
    required File petImage,
    required PetCategory petCategory,
  }) async {
    try {
      String fileName = petImage.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          petImage.path,
          filename: fileName,
          contentType: MediaType('image', 'png'),
        )
      });

      var imagePath = await _apiAdapter.post(
        "/uploads",
        data: formData,
        options: Options(
          headers: {
            "requiresToken": true,
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      var response = await _apiAdapter.post(
        "/pets",
        data: {
          "breed": breed,
          "name": petName,
          "age": age,
          "vaccine": vaccine,
          "pet_image": imagePath.data,
          "year_or_month": yearOrMonth.name,
          "bio": description,
          "state": state,
          "city": city,
          "pet_category": petCategory.name,
        },
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );

      return {
        "petId": response.data['id'],
        "petImage": imagePath.data,
      };
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return {
      "petId": null,
      "petImage": null,
    };
  }

  Future<Map<String, dynamic>> addPost({
    required PetCategory petCategory,
    required String petId,
    required String imageId,
  }) async {
    try {
      var response = await _apiAdapter.post(
        "/posts",
        data: {
          "pet_id": petId,
          "image_id": imageId,
          "post_type": petCategory.name,
        },
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );
      return {'postId': response.data['id']};
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return {
      'postId': null,
    };
  }

  Future<bool> removePost({
    required String petId,
    required String postId,
  }) async {
    try {
      await _apiAdapter.delete(
        "/posts",
        data: {
          "post_id": postId,
          "pet_id": petId,
        },
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );
      _userController.removePet(_petDetailsController.petDetail);
      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<Map<String, dynamic>> savePetNormalPost({
    required File image,
    required String description,
  }) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType('image', 'png'),
        )
      });
      var imagePath = await _apiAdapter.post(
        "/uploads",
        data: formData,
        options: Options(
          headers: {
            "requiresToken": true,
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      var responsePet = await _apiAdapter.post(
        "/pets",
        data: {
          "bio": description,
          "breed": '',
          "pet_image": imagePath.data,
          "pet_category": 'normal',
          "year_or_month": "years",
        },
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );

      return {
        'petImage': imagePath.data,
        'petId': responsePet.data['id'],
      };
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return {
      "petId": null,
      "petImage": null,
    };
  }

  Future<bool> likePost({
    required String postId,
  }) async {
    try {
      await _apiAdapter.post(
        '/posts/likes',
        data: {
          "post_id": postId,
        },
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> deleteLikePost({
    required String postId,
  }) async {
    try {
      await _apiAdapter.delete(
        '/posts/likes',
        data: {
          "post_id": postId,
        },
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> searchUsers({
    required String textToSearch,
  }) async {
    try {
      var response = await _apiAdapter.get(
        '/users/search?text=$textToSearch',
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );

      final List<UserEntity> userList = response.data
          .map<UserEntity>(
            (user) => UserEntity(
              id: user['id'],
              email: '',
              name: user['name'],
              userName: user['user_name'],
              profileImage: user['profile_image'] ?? '',
              backgroundImage: user['background_image'] ?? '',
              bio: user['bio'] ?? '',
            ),
          )
          .toList();

      _externalProfileController.userList = userList;

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> getFilteredPets({
    required PetCategory petCategory,
    required int page,
    String createdAt = '',
    String breed = '',
    String city = '',
    String state = '',
  }) async {
    try {
      var response = await _apiAdapter.get(
        '/pets/filter-pets?category=${petCategory.name}&page=$page&created_at=$createdAt&breed=$breed&city=$city&=state=$state',
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );

      List<PetEntity> petList = response.data != null
          ? response.data['data']
              .map<PetEntity>(
                (pet) => PetEntity(
                  id: pet['id'],
                  userId: pet['user_id'],
                  breed: pet['breed'] ?? '',
                  age: pet['age'],
                  name: pet['name'] ?? '',
                  petImage: pet['pet_image'] ?? '',
                  vaccine: pet['vaccine'] ?? false,
                  yearOrMonth: YearOrMonth.values.firstWhere((yearOrMonth) =>
                      yearOrMonth.name == pet['year_or_month']),
                  description: pet['bio'] ?? '',
                  city: pet['city'],
                  state: pet['state'],
                  category: PetCategory.values.firstWhere(
                      (category) => category.name == pet['pet_category']),
                  createdAt: DateTime.parse(pet['created_at']),
                  petOwnerName: pet['user']['name'] ?? '',
                  petOwnerImage: pet['user']['profile_image'] ?? '',
                ),
              )
              .toList()
          : [];

      if (petList.length < 5) {
        _adoptionController.maxPetsReached = true;
      } else {
        _adoptionController.page += 1;
      }

      if (page == 0 && petList.isNotEmpty) {
        _adoptionController.filteredPetList = [
          ...petList,
        ];
      } else {
        _adoptionController.filteredPetList = [
          ..._adoptionController.filteredPetList,
          ...petList,
        ];
      }

      if (petList.isEmpty) {
        Get.snackbar(
          "Ops!",
          "Não foram encontrados pets com o filtro selecionado",
          duration: const Duration(
            seconds: 3,
          ),
          backgroundColor: primary,
          colorText: base,
        );
      }

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> updatePost({
    required String id,
    required String petId,
    String? breed,
    String? petName,
    int? age,
    bool? vaccine,
    YearOrMonth? yearOrMonth = YearOrMonth.years,
    String? description,
    String? state,
    String? city,
    required File petImage,
    required PetCategory petCategory,
    required DateTime createdAt,
  }) async {
    _publicationPageController.loadingPublication = true;
    try {
      dynamic imagePath;

      if (petImage.path.isNotEmpty) {
        String fileName = petImage.path.split('/').last;
        FormData formData = FormData.fromMap({
          "image": await MultipartFile.fromFile(
            petImage.path,
            filename: fileName,
            contentType: MediaType('image', 'png'),
          )
        });

        imagePath = await _apiAdapter.post(
          "/uploads",
          data: formData,
          options: Options(
            headers: {
              "requiresToken": true,
              "Content-Type": "multipart/form-data",
            },
          ),
        );
      } else {
        imagePath = _publicationPageController.postEntityTemp.pet!.petImage;
      }

      await _apiAdapter.put(
        "/pets",
        data: {
          "id": id,
          "breed": breed ?? '',
          "name": petName ?? '',
          "age": age,
          "vaccine": vaccine ?? false,
          "pet_image": petImage.path.isNotEmpty ? imagePath.data : imagePath,
          "year_or_month": yearOrMonth!.name,
          "bio": description ?? '',
          "state": state ?? '',
          "city": city ?? '',
          "pet_category": petCategory.name,
        },
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );

      final UserEntity user = _userController.userEntity;

      final PetEntity petEntity = PetEntity(
        id: petId,
        postId: id,
        userId: user.id,
        breed: breed ?? '',
        age: age,
        yearOrMonth:
            YearOrMonth.values.firstWhere((element) => element == yearOrMonth),
        vaccine: vaccine ?? false,
        name: petName ?? '',
        description: description ?? '',
        category: petCategory,
        petImage: petImage.path.isNotEmpty ? imagePath.data : imagePath,
        state: state ?? '',
        city: city ?? '',
        petOwnerName: user.name,
        petOwnerImage: user.profileImage,
        createdAt: createdAt,
      );

      if (petEntity.category == PetCategory.adoption) {
        _userController.updateAdoptionPet(petEntity);
        _adoptionController.updatePet(petEntity);
      }
      _userController.updatePostById(petEntity.postId!, petEntity);
      _feedController.updatePostById(petEntity.postId!, petEntity);

      _publicationPageController.loadingPublication = false;
      return true;
    } on DioError catch (e) {
      _publicationPageController.loadingPublication = false;
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> getUserById({
    required String userId,
  }) async {
    try {
      var response = await _apiAdapter.get(
        '/users/$userId',
        options: Options(
          headers: {
            "requiresToken": true,
          },
        ),
      );

      UserEntity userEntity = UserEntity(
        id: response.data['id'],
        email: response.data['email'],
        name: response.data['name'],
        userName: response.data['user_name'],
        profileImage: response.data['profile_image'] ?? '',
        backgroundImage: response.data['background_image'] ?? '',
        bio: response.data['bio'] ?? '',
      );

      _externalProfileController.externalUserEntity = userEntity;

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<void> goToExternalProfileById({
    required String userId,
    bool goToMyProfile = false,
  }) async {
    if (userId != _userController.userEntity.id) {
      _externalProfileController.loadingProfile = true;
      Get.toNamed(Routes.externalProfile);
      try {
        await ApiController().fetchExternalUserInfo(userId);
      } catch (e) {
        Get.snackbar(
          "Erro",
          "Erro ao informações do perfil.",
          backgroundColor: primary,
          colorText: base,
          duration: const Duration(seconds: 2),
        );
      }
      await Future.delayed(const Duration(seconds: 1));
      _externalProfileController.loadingProfile = false;
    } else if (goToMyProfile) {
      Get.offAndToNamed(Routes.home);
      _homePageController.isBottomTabVisible = true;
      _homePageController.selectedIndex = 4;
    }
  }
}


// Future<bool> deleteLikePost({
//     required String postId,
//   }) async {
//     try {
//       await _apiAdapter.delete(
//         '/posts/likes',
//         data: {
//           "post_id": postId,
//         },
//         options: Options(
//           headers: {
//             "requiresToken": true,
//           },
//         ),
//       );

//       return true;
//     } on DioError catch (e) {
//       showSnackbar(e);
//     }

//     return false;
//   }