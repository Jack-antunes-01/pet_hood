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

  final PetCategory category;

  PetEntity({
    required this.id,
    required this.userId,
    this.name,
    required this.breed,
    this.vaccine,
    required this.description,
    this.age,
    this.yearOrMonth,
    required this.city,
    required this.state,
    this.petImage,
    this.petImageFile,
    required this.category,
    required this.createdAt,
  });

  // PetCategory.values.firstWhere((element) => element == category),

}
