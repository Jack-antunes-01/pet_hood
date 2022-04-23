import 'package:get/get.dart';
import 'package:pet_hood/core/entities/post_entity.dart';

class FeedController extends GetxController {
  FeedController._privateConstructor();

  static final FeedController _instance = FeedController._privateConstructor();

  factory FeedController() {
    return _instance;
  }

  final RxList<PostEntity> _listPosts = RxList<PostEntity>([
    PostEntity(
      type: PostTypeEnum.normal,
      name: "Jack Antunes",
      avatar: "assets/images/dog_image.png",
      username: "jack_antunes01",
      isOwner: true,
      postImage: "assets/images/dog_image.png",
      qtLikes: 122,
      isLiked: true,
      postedAt: DateTime(2022, 01, 01),
      description: "Eu amo meu gatineo!!",
    ),
    PostEntity(
      type: PostTypeEnum.adoption,
      name: "Jack Antunes",
      avatar: "assets/images/dog_image.png",
      username: "jack_antunes01",
      isOwner: true,
      postImage: "assets/images/dog_image.png",
      postedAt: DateTime(2022, 01, 01),
      age: 3,
      breed: "Vira-lata",
      vaccine: false,
      weight: 6.43,
      petName: "Salah",
    ),
    PostEntity(
      type: PostTypeEnum.disappear,
      name: "Jack Antunes",
      avatar: "assets/images/dog_image.png",
      username: "jack_antunes01",
      isOwner: true,
      postImage: "assets/images/dog_image.png",
      postedAt: DateTime(2022, 01, 01),
      description: "Eu amo meu gatineo!!",
      petName: "Sansão",
      dateMissing: "02/02/2022",
      breed: "Vira-lata",
      age: 5,
    ),
    PostEntity(
      type: PostTypeEnum.found,
      name: "Jack Antunes",
      avatar: "assets/images/dog_image.png",
      username: "jack_antunes01",
      isOwner: true,
      postImage: "assets/images/dog_image.png",
      postedAt: DateTime(2022, 01, 01),
      description: "Eu amo meu gatineo!!",
      dateFound: "01/02/2022",
      breed: "Vira-lata",
    ),
  ]);

  List<PostEntity> get listPosts => _listPosts;

  set listPosts(List<PostEntity> posts) => _listPosts.value = posts;
}
