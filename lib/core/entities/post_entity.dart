import 'dart:io';
import 'package:pet_hood/core/entities/entities.dart';

enum PostTypeEnum {
  normal,
  adoption,
  disappear,
  found,
}

class PostEntity {
  final PostTypeEnum type;

  final String id;
  final String avatar;
  final String name;
  final String username;
  final bool isOwner;
  final String? postImage;
  final File? postImageFile;
  int? qtLikes;
  bool? isLiked;
  final DateTime postedAt;

  final PetEntity? pet;

  PostEntity({
    required this.id,
    required this.type,
    required this.name,
    required this.avatar,
    required this.username,
    required this.isOwner,
    required this.postedAt,
    this.postImage,
    this.postImageFile,
    this.qtLikes,
    this.isLiked,
    this.pet,
  });
}
