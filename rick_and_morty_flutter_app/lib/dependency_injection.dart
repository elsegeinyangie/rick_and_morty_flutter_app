import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_flutter_app/features/characters/data/datasources/local/local_data_source.dart';
import 'package:rick_and_morty_flutter_app/features/characters/data/datasources/remote/remote_data_source.dart';
import 'package:rick_and_morty_flutter_app/features/characters/data/repositories/character_repository_impl.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/usecases/character_usecase.dart';

final getIt = GetIt.instance;

void setup() {
  ///register [http] client for [api requests]
  getIt.registerLazySingleton(() => http.Client());

  /// register [remoteDataSource]
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: getIt<http.Client>()));

  /// register [localDataSource]
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  /// register [characterRepository]
  getIt.registerLazySingleton<CharacterRepository>(() =>
      CharacterRepositoryImpl(
          localDataSource: getIt<LocalDataSource>(),
          remoteDataSource: getIt<RemoteDataSource>()));

  /// register [usecase]
  getIt.registerLazySingleton<CharacterUsecase>(
      () => CharacterUsecase(repository: getIt<CharacterRepository>()));
}
