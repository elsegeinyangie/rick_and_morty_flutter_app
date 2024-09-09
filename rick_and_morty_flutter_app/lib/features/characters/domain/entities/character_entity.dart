// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String location;
  final String image;
  final List<String> episodes;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.location,
    required this.image,
    required this.episodes,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, name, status, species, gender, location, image, episodes];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}
