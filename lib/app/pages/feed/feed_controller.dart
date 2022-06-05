import 'package:get/get.dart';
import 'package:pet_hood/app/data/data.dart';
import 'package:pet_hood/core/entities/entities.dart';

class FeedController extends GetxController {
  final RxList<PostEntity> _listPosts = RxList<PostEntity>(getPostList());
  List<PostEntity> get listPosts => _listPosts;
  set listPosts(List<PostEntity> posts) => _listPosts.value = posts;

  addPost(PostEntity post) {
    listPosts.insert(0, post);
  }

  removePublication(String postId) {
    listPosts.removeWhere((post) => post.id == postId);
    _listPosts.refresh();
  }

  void updatePost(PostEntity post) {
    int index = listPosts.indexWhere((p) => p.id == post.id);
    listPosts[index] = post;
    _listPosts.refresh();
  }

  void updatePostById(String postId, PetEntity pet) {
    int index = listPosts.indexWhere((p) => p.id == postId);
    PostEntity post = listPosts.firstWhere((element) => element.id == postId);
    PostEntity newPost = PostEntity(
      id: post.id,
      type: post.type,
      name: post.name,
      avatar: post.avatar,
      username: post.username,
      isOwner: post.isOwner,
      postedAt: post.postedAt,
      postImageFile: post.postImageFile,
      description: post.description,
      pet: pet,
    );
    listPosts[index] = newPost;
    _listPosts.refresh();
  }
}
