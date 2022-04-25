enum PetCategory { adoption, disappear, found }

class PetEntity {
  final String id;
  final String userId;
  final String name;
  final String breed;
  final bool vaccine;
  final String description;
  final DateTime age;
  final String city;
  final String state;
  final String petImage;
  final DateTime createdAt;

  final PetCategory category;

  PetEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.breed,
    required this.vaccine,
    required this.description,
    required this.age,
    required this.city,
    required this.state,
    required this.petImage,
    required this.category,
    required this.createdAt,
  });

  // PetCategory.values.firstWhere((element) => element == category),

}
