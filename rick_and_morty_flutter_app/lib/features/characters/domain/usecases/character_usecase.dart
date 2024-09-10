import 'package:rick_and_morty_flutter_app/features/characters/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';

class CharacterUsecase {
  final CharacterRepository characterRepository;

  CharacterUsecase({required this.characterRepository});

  Future<List<CharacterEntity>> execute() async {
    return await characterRepository.getCharacters();
  }
}
