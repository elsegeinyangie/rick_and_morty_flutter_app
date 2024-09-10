import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  //a method to fetch a user
  Future<List<CharacterEntity>> getCharacters();
}
