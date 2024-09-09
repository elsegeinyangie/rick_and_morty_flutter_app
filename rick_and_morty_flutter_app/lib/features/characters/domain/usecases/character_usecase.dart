import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/repositories/character_repository.dart';

class CharacterUsecase {
  final CharacterRepository repository;

  //reposity dependecy injection
  CharacterUsecase({required this.repository});

  //execute method calls the repository to get the character
  Future<CharacterEntity> execute() async {
    return repository.getCharacter();
  }
}
