import 'dart:convert';

class UserEntity {
  String id;
  String email;
  String name;
  String userName;
  String? profileImage;
  String? backgroundImage;
  String? bio;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.userName,
    required this.profileImage,
    required this.backgroundImage,
    required this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userName': userName,
      'profileImage': profileImage,
      'backgroundImage': backgroundImage,
      'bio': bio,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      userName: map['userName'] ?? '',
      profileImage: map['profileImage'] ?? '',
      backgroundImage: map['backgroundImage'] ?? '',
      bio: map['bio'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, name: $name, userName: $userName, profileImage: $profileImage, backgroundImage: $backgroundImage, bio: $bio)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.userName == userName &&
        other.profileImage == profileImage &&
        other.backgroundImage == backgroundImage &&
        other.bio == bio;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        userName.hashCode ^
        profileImage.hashCode ^
        backgroundImage.hashCode ^
        bio.hashCode;
  }
}
