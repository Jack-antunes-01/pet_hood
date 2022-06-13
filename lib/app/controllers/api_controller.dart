import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_hood/app/controllers/controllers.dart';
import 'package:pet_hood/app/controllers/external_profile_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/entities.dart';
import 'package:pet_hood/database/api_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class ApiController {
  final ApiAdapter _apiAdapter = Get.find();
  final UserController _userController = Get.find();
  final PetDetailsController _petDetailsController = Get.find();
  // final AdoptionController _adoptionController = Get.find();
  final FeedController _feedController = Get.find();
  final ExternalProfileController _externalProfileController = Get.find();

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

    _userController.clear();

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

      fetchAllUserInfo();

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  fetchAllUserInfo() async {
    var postsLoaded = await getFeedPosts();
    var petsLoaded = await getProfilePets();
    await getPostsByUserId(userId: _userController.userEntity.id);

    if (postsLoaded && petsLoaded) {
      Get.snackbar(
        "Sucesso!",
        "Informações carregadas!",
        duration: const Duration(
          seconds: 2,
        ),
        backgroundColor: primary,
        colorText: base,
      );
    }
  }

  Future<bool> getFeedPosts({
    int? limit = 10,
    int? page = 1,
    int? offset = 0,
  }) async {
    try {
      var response = await _apiAdapter.get(
        "/posts?limit=$limit&page=$page&offset=$offset",
        options: options,
      );

      List<PostEntity> postList = response.data != null
          ? response.data['data']
              .map<PostEntity>((post) => PostEntity(
                    id: post['id'],
                    type: PostTypeEnum.values.firstWhere(
                        (element) => element.name == post['post_type']),
                    name: post['user']['name'],
                    avatar: post['user']['profile_image'] ?? '',
                    username: post['user']['user_name'],
                    isOwner:
                        post['user']['id'] == _userController.userEntity.id,
                    postImage: post['pet']['pet_image'],
                    postedAt: DateTime.parse(post['created_at']),
                    isLiked: post['post_likes'].firstWhere((item) =>
                            item['user_id'] == _userController.userEntity.id) !=
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
                      description: post['pet']['description'] ?? '',
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

      _feedController.listPosts = [..._feedController.listPosts, ...postList];

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
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

      _userController.petList = petList;

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  fetchExternalUserInfo(String userId) async {
    var postsLoaded = await getPostsByUserId(userId: userId);
    var petsLoaded = await getProfilePetsByUserId(userId: userId);

    if (postsLoaded && petsLoaded) {
      Get.snackbar(
        "Sucesso!",
        "Informações carregadas!",
        duration: const Duration(
          seconds: 2,
        ),
        backgroundColor: primary,
        colorText: base,
      );
    }
  }

  Future<bool> getPostsByUserId({
    int? limit = 10,
    int? page = 1,
    int? offset = 0,
    required String userId,
  }) async {
    try {
      var response = await _apiAdapter.get(
        "/posts/$userId?limit=$limit&page=$page&offset=$offset",
        options: options,
      );

      List<PostEntity> postList = response.data != null
          ? response.data['data']
              .map<PostEntity>((post) => PostEntity(
                    id: post['id'],
                    type: PostTypeEnum.values.firstWhere(
                        (element) => element.name == post['post_type']),
                    name: post['user']['name'],
                    avatar: post['user']['profile_image'] ?? '',
                    username: post['user']['user_name'],
                    isOwner:
                        post['user']['id'] == _userController.userEntity.id,
                    postImage: post['pet']['pet_image'],
                    postedAt: DateTime.parse(post['created_at']),
                    isLiked: post['post_likes'].firstWhere((item) =>
                            item['user_id'] == _userController.userEntity.id) !=
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
                      description: post['pet']['description'] ?? '',
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

      if (userId == _userController.userEntity.id) {
        _userController.postList = postList;
      } else {
        _externalProfileController.postList = postList;
      }

      return true;
    } on DioError catch (e) {
      showSnackbar(e);
    }

    return false;
  }

  Future<bool> getProfilePetsByUserId({required String userId}) async {
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
                    petOwnerName: _userController.userEntity.name,
                    petOwnerImage: _userController.userEntity.profileImage,
                  ))
              .toList()
          : [];

      _externalProfileController.petList = petList;

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
          "description": description,
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
    required PostTypeEnum postType,
    required String petId,
    required String imageId,
  }) async {
    try {
      var response = await _apiAdapter.post(
        "/posts",
        data: {
          "pet_id": petId,
          "image_id": imageId,
          "post_type": postType.name,
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
          "description": description,
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