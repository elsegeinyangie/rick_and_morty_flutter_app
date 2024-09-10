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
  Future<CharacterEntity> getCharacter() async {
    //first check the internet connectivity status
    final connectivityResult = await connectivity.checkConnectivity();

    //if there is internet, try to fetch the character data from the remote source (api)
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final character = await remoteDataSource.fetchRemoteData();
        //cache the retrieved data
        localDataSource.cacheCharacter(character as CharacterModel);
        return character; //return fetched character
      } catch (e) {
        throw Exception('Failed to cache character: ${e.toString()}');
      }
    } else {
      //if there is no internet connection, fetch data from local cache
      try {
        return await localDataSource.getCachedData();
      } catch (e) {
                throw Exception('No internet connection and failed to get cached character: ${e.toString()}');

      }
    }
  }
}
