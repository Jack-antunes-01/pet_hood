enum PostTypeEnum {
  normal,
  adoption,
  disappear,
  found,
}

class PostEntity {
  final PostTypeEnum type;

  final String avatar;
  final String name;
  final String username;
  final bool isOwner;
  final String? description;
  final String postImage;
  int? qtLikes;
  bool? isLiked;
  final DateTime postedAt;

  final int? age;
  final String? breed;
  final bool? vaccine;
  final double? weight;

  final String? dateMissing;
  final String? petName;

  final String? dateFound;

  PostEntity({
    required this.type,
    required this.name,
    required this.avatar,
    required this.username,
    required this.isOwner,
    required this.postImage,
    required this.postedAt,
    this.qtLikes,
    this.isLiked,
    this.description,
    this.age,
    this.breed,
    this.vaccine,
    this.weight,
    this.dateMissing,
    this.petName,
    this.dateFound,
  });
}
