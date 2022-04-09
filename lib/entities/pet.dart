enum PetCategory { adoption, disappear, found }

class Pet {
  String name;
  String location;
  String distance;
  PetCategory category;
  String imageUrl;
  bool favorite;
  bool newest;

  Pet({
    required this.name,
    required this.location,
    required this.distance,
    required this.category,
    required this.imageUrl,
    required this.favorite,
    required this.newest,
  });
}
