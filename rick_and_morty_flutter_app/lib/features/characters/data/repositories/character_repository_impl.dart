import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rick_and_morty_flutter_app/core/error/exceptions.dart';
import 'package:rick_and_morty_flutter_app/features/characters/data/datasources/local/local_data_source.dart';
import 'package:rick_and_morty_flutter_app/features/characters/data/datasources/remote/remote_data_source.dart';
import 'package:rick_and_morty_flutter_app/features/characters/data/models/character_model.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final Connectivity connectivity;

  CharacterRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.connectivity});

  @override
  Future<List<CharacterEntity>> getCharacters() async {
    //first check the internet connectivity status
    final connectivityResult = await connectivity.checkConnectivity();

    //if there is internet, try to fetch the character data from the remote source (api)
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final List<CharacterModel> characters =
            await remoteDataSource.fetchAllCharacters();
        //cache the retrieved data
        localDataSource.cacheCharacters(characters);
        return characters; //return fetched character
      } catch (e) {
        throw Exception('Failed to cache character: ${e.toString()}');
      }
    } else {
      //if there is no internet connection, fetch data from local cache
      try {
        final cachedCharacters = await localDataSource.getCachedCharacters();
        return cachedCharacters;
      } catch (e) {
        throw Exception(
            'No internet connection and failed to get cached character: ${e.toString()}');
      }
    }
  }
}
