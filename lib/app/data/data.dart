import 'dart:math';

import 'package:pet_hood/core/entities/pet_entity.dart';

List<PetEntity> getPetList() {
  return <PetEntity>[
    PetEntity(
      name: "Abyssinian Cats",
      city: "California",
      category: PetCategory.adoption,
      petImage: "assets/images/cats/cat_1.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Scottish Fold",
      city: "New Jersey",
      category: PetCategory.found,
      petImage: "assets/images/cats/cat_2.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Ragdoll",
      city: "Miami",
      category: PetCategory.disappear,
      petImage: "assets/images/cats/cat_3.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Burmés",
      city: "Chicago",
      category: PetCategory.disappear,
      petImage: "assets/images/cats/cat_4.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "American Shorthair",
      city: "Washintong",
      category: PetCategory.found,
      petImage: "assets/images/cats/cat_5.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "British Shorthair",
      city: "New York",
      category: PetCategory.adoption,
      petImage: "assets/images/cats/cat_6.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Abyssinian Cats",
      city: "California",
      category: PetCategory.adoption,
      petImage: "assets/images/cats/cat_7.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Scottish Fold",
      city: "New Jersey",
      category: PetCategory.found,
      petImage: "assets/images/cats/cat_8.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Ragdoll",
      city: "Miami",
      category: PetCategory.disappear,
      petImage: "assets/images/cats/cat_9.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Roborowski",
      city: "California",
      category: PetCategory.adoption,
      petImage: "assets/images/hamsters/hamster_1.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Ruso",
      city: "New Jersey",
      category: PetCategory.found,
      petImage: "assets/images/hamsters/hamster_2.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Golden",
      city: "Miami",
      category: PetCategory.disappear,
      petImage: "assets/images/hamsters/hamster_3.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Chinese",
      city: "Chicago",
      category: PetCategory.disappear,
      petImage: "assets/images/hamsters/hamster_4.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Dwarf Campbell",
      city: "New York",
      category: PetCategory.adoption,
      petImage: "assets/images/hamsters/hamster_5.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Syrian",
      city: "California",
      category: PetCategory.adoption,
      petImage: "assets/images/hamsters/hamster_6.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Dwarf Winter",
      city: "Miami",
      category: PetCategory.found,
      petImage: "assets/images/hamsters/hamster_7.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "American Rabbit",
      city: "California",
      category: PetCategory.adoption,
      petImage: "assets/images/bunnies/bunny_1.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Belgian Hare Rabbit",
      city: "New Jersey",
      category: PetCategory.found,
      petImage: "assets/images/bunnies/bunny_2.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Blanc de Hotot",
      city: "Miami",
      category: PetCategory.disappear,
      petImage: "assets/images/bunnies/bunny_3.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Californian Rabbits",
      city: "Chicago",
      category: PetCategory.disappear,
      petImage: "assets/images/bunnies/bunny_4.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Checkered Giant Rabbit",
      city: "New York",
      category: PetCategory.adoption,
      petImage: "assets/images/bunnies/bunny_5.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Dutch Rabbit",
      city: "California",
      category: PetCategory.adoption,
      petImage: "assets/images/bunnies/bunny_6.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "English Lop",
      city: "Miami",
      category: PetCategory.found,
      petImage: "assets/images/bunnies/bunny_7.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "English Spot",
      city: "California",
      category: PetCategory.adoption,
      petImage: "assets/images/bunnies/bunny_8.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Affenpinscher",
      city: "California",
      category: PetCategory.adoption,
      petImage: "assets/images/dogs/dog_1.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Akita Shepherd",
      city: "New Jersey",
      category: PetCategory.found,
      petImage: "assets/images/dogs/dog_2.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "American Foxhound",
      city: "Miami",
      category: PetCategory.disappear,
      petImage: "assets/images/dogs/dog_3.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Shepherd Dog",
      city: "Chicago",
      category: PetCategory.disappear,
      petImage: "assets/images/dogs/dog_4.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Australian Terrier",
      city: "New York",
      category: PetCategory.adoption,
      petImage: "assets/images/dogs/dog_5.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Bearded Collie",
      city: "California",
      category: PetCategory.adoption,
      petImage: "assets/images/dogs/dog_6.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Belgian Sheepdog",
      city: "Miami",
      category: PetCategory.found,
      petImage: "assets/images/dogs/dog_7.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Bloodhound",
      city: "California",
      category: PetCategory.adoption,
      petImage: "assets/images/dogs/dog_8.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Boston Terrier",
      city: "California",
      category: PetCategory.adoption,
      petImage: "assets/images/dogs/dog_9.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Chinese Shar-Pei",
      city: "New Jersey",
      category: PetCategory.found,
      petImage: "assets/images/dogs/dog_10.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Border Collie",
      city: "Miami",
      category: PetCategory.disappear,
      petImage: "assets/images/dogs/dog_11.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
    PetEntity(
      name: "Chow Chow",
      city: "Chicago",
      category: PetCategory.disappear,
      petImage: "assets/images/dogs/dog_12.jpg",
      createdAt: DateTime.now(),
      age: DateTime(2021, 01, 01),
      breed: "Vira-lata",
      description: "Animal maravilhoso de fofo demais jentiiiiii",
      id: Random().nextInt(10000).toString(),
      vaccine: Random().nextBool(),
      userId: Random().nextInt(10000).toString(),
    ),
  ];
}
