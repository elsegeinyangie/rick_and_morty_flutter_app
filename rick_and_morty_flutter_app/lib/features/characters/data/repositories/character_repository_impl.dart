import 'package:rick_and_morty_flutter_app/core/error/exceptions.dart';
import 'package:rick_and_morty_flutter_app/features/characters/data/datasources/local/local_data_source.dart';
import 'package:rick_and_morty_flutter_app/features/characters/data/datasources/remote/remote_data_source.dart';
import 'package:rick_and_morty_flutter_app/features/characters/data/models/character_model.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  CharacterRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<CharacterEntity> getCharacter() async {
    try {
      //try to fetch the character data from the remote source (api)
      final character = await remoteDataSource.fetchRemoteData();
      //cache the retrieved data
      localDataSource.cacheCharacter(character as CharacterModel);
      return character; //return fetched character
    } on CacheException catch (e) {
      throw Exception('Failed to cache character: ${e.toString()}');
    } catch (e) {
      // If an error occurs, try to get cached data
      try {
        return await localDataSource.getCachedData();
      } catch (cacheError) {
        // If getting cached data also fails, rethrow the original error
        throw Exception('Failed to fetch character data: ${e.toString()}');
      }
    }
  }
}
