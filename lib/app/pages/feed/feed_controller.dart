import 'package:get/get.dart';
import 'package:pet_hood/core/entities/entities.dart';

class FeedController extends GetxController {
  FeedController._privateConstructor();
  static final FeedController _instance = FeedController._privateConstructor();
  factory FeedController() {
    return _instance;
  }

  final RxInt _page = RxInt(0);
  int get page => _page.value;
  set page(int page) => _page.value = page;

  final RxBool _maxPostsReached = RxBool(false);
  bool get maxPostsReached => _maxPostsReached.value;
  set maxPostsReached(bool isMaxPostsReached) =>
      _maxPostsReached.value = isMaxPostsReached;

  final RxBool _loadingFeed = RxBool(false);
  bool get loadingFeed => _loadingFeed.value;
  set loadingFeed(bool isLoadingFeed) => _loadingFeed.value = isLoadingFeed;

  final RxBool _loadMoreFeed = RxBool(false);
  bool get loadMoreFeed => _loadMoreFeed.value;
  set loadMoreFeed(bool isLoadMoreFeed) => _loadMoreFeed.value = isLoadMoreFeed;

  final RxList<PostEntity> _listPosts = RxList<PostEntity>();
  List<PostEntity> get listPosts => _listPosts;
  set listPosts(List<PostEntity> posts) => {
        _listPosts.value = posts,
        _listPosts.refresh(),
      };

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
    if (index != -1) {
      PostEntity post = listPosts.firstWhere((element) => element.id == postId);
      PostEntity newPost = PostEntity(
        id: post.id,
        userId: post.userId,
        name: post.name,
        avatar: post.avatar,
        username: post.username,
        isOwner: post.isOwner,
        postedAt: post.postedAt,
        pet: pet,
        isLiked: post.isLiked,
        qtLikes: post.qtLikes,
      );
      listPosts[index] = newPost;
      _listPosts.refresh();
    }
  }

  void clear() {
    listPosts = [];
    page = 0;
    maxPostsReached = false;
    loadingFeed = false;
    loadMoreFeed = false;
  }
}
