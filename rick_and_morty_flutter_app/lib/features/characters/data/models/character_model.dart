import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String location;
  final String image;
  final List<String> episodes;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.location,
    required this.image,
    required this.episodes,
  }) : super(
          id: id,
          name: name,
          status: status,
          species: species,
          gender: gender,
          location: location,
          image: image,
          episodes: episodes,
        );

  // Factory method to create a CharacterModel from JSON
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      location: json['location']['name'], // extract on the name of the location
      image: json['image'],
      episodes: List<String>.from(json['episode']),
    );
  }

  // Method to convert CharacterModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
      'location': {'name': location},
      'image': image,
      'episode': episodes,
    };
  }
}
