import 'package:pet_hood/core/entities/entities.dart';

class PostEntity {
  final String id;
  final String userId;
  final String avatar;
  final String name;
  final String username;
  final bool isOwner;
  int? qtLikes;
  bool? isLiked;
  final DateTime postedAt;

  final PetEntity? pet;

  PostEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.avatar,
    required this.username,
    required this.isOwner,
    required this.postedAt,
    this.qtLikes,
    this.isLiked,
    this.pet,
  });
}
