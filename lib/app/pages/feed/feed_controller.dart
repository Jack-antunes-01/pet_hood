import 'package:get/get.dart';
import 'package:pet_hood/app/data/data.dart';
import 'package:pet_hood/core/entities/post_entity.dart';

class FeedController extends GetxController {
  FeedController._privateConstructor();

  static final FeedController _instance = FeedController._privateConstructor();

  factory FeedController() {
    return _instance;
  }

  final RxList<PostEntity> _listPosts = RxList<PostEntity>(getPostList());

  List<PostEntity> get listPosts => _listPosts;

  set listPosts(List<PostEntity> posts) => _listPosts.value = posts;
}
