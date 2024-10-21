class CharacterModel {
  final String name;
  final String house;
  final String image;
  final String yearOfBirth;
  final String species;

  CharacterModel(
      {required this.name,
      required this.house,
      required this.image,
      required this.yearOfBirth,
      required this.species});

  //factory constructor, con el fromjson transforma de json a tipo caracter
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
        name: json['name'],
        house: json['house'] ?? 'Unknown',
        image: json['image'],
        yearOfBirth: json['yearOfBirth']?.toString() ?? 'Unknown',
        species: json['species']);
  }

  //el que transforma de tipo caracter a json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'house': house,
      'image': image,
      'yearOfBirth': yearOfBirth,
      'species': species,
    };
  }
}
