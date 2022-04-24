import 'dart:convert';

class UserEntity {
  final String id;
  String email;
  String name;
  String userName;
  String phoneNumber;
  String profileImage;
  String backgroundImage;
  String birthDate;
  String bio;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.userName,
    required this.phoneNumber,
    required this.profileImage,
    required this.backgroundImage,
    required this.birthDate,
    required this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'backgroundImage': backgroundImage,
      'birthDate': birthDate,
      'bio': bio,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      userName: map['userName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profileImage: map['profileImage'] ?? '',
      backgroundImage: map['backgroundImage'] ?? '',
      birthDate: map['birthDate'] ?? '',
      bio: map['bio'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, name: $name, userName: $userName, phoneNumber: $phoneNumber, profileImage: $profileImage, backgroundImage: $backgroundImage, birthDate: $birthDate, bio: $bio)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.userName == userName &&
        other.phoneNumber == phoneNumber &&
        other.profileImage == profileImage &&
        other.backgroundImage == backgroundImage &&
        other.birthDate == birthDate &&
        other.bio == bio;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        userName.hashCode ^
        phoneNumber.hashCode ^
        profileImage.hashCode ^
        backgroundImage.hashCode ^
        birthDate.hashCode ^
        bio.hashCode;
  }
}
