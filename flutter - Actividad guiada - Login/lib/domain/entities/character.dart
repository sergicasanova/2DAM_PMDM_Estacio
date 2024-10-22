class Character {
  final String name;
  final String house;
  final String image;
  final String? yearOfBirth;
  final String species;

  Character({
    required this.name,
    required this.house,
    required this.image,
    this.yearOfBirth,
    required this.species,
  });
}
