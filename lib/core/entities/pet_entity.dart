import 'dart:io';

enum PetCategory { adoption, disappear, found }
enum YearOrMonth { years, months }

class PetEntity {
  final String id;
  final String userId;
  final String? name;
  final String? breed;
  final bool? vaccine;
  final String description;
  final int? age;
  final YearOrMonth? yearOrMonth;
  final String city;
  final String state;
  final String? petImage;
  final File? petImageFile;
  final DateTime createdAt;
  final String petOwnerName;
  final File? petOwnerImageFile;
  final String? petOwnerImage;

  final PetCategory category;

  PetEntity({
    required this.id,
    required this.userId,
    required this.breed,
    required this.description,
    required this.city,
    required this.state,
    required this.category,
    required this.createdAt,
    required this.petOwnerName,
    required this.petOwnerImage,
    this.petOwnerImageFile,
    this.name,
    this.vaccine,
    this.age,
    this.yearOrMonth,
    this.petImage,
    this.petImageFile,
  });

  // PetCategory.values.firstWhere((element) => element == category),

}
