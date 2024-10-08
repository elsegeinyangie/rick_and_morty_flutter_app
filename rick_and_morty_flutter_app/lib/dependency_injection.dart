import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_flutter_app/features/characters/data/datasources/local/local_data_source.dart';
import 'package:rick_and_morty_flutter_app/features/characters/data/datasources/remote/remote_data_source.dart';
import 'package:rick_and_morty_flutter_app/features/characters/data/repositories/character_repository_impl.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/usecases/character_usecase.dart';
import 'package:rick_and_morty_flutter_app/features/characters/presentation/bloc/app_theme/app_theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/characters/presentation/bloc/views/view_cubit.dart';

final getIt = GetIt.instance;

void setup() {
  ///register [http] client for [api requests]
  getIt.registerLazySingleton(() => http.Client());

  /// register [Shared Prefereneces]
  getIt.registerLazySingleton<SharedPreferencesAsync>(
      () => SharedPreferencesAsync());

  /// register [remoteDataSource]
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: getIt<http.Client>()));

  /// register [localDataSource]
  getIt.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(asyncPrefs: getIt<SharedPreferencesAsync>()));

  ///register [connectivity checker]
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  /// register [characterRepository]
  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      localDataSource: getIt<LocalDataSource>(),
      remoteDataSource: getIt<RemoteDataSource>(),
      connectivity: getIt(),
    ),
  );

  /// register [usecase]
  getIt.registerLazySingleton<CharacterUsecase>(
    () => CharacterUsecase(characterRepository: getIt<CharacterRepository>()),
  );

  ///register [themesCubit]
  getIt.registerLazySingleton(() => AppThemeCubit());

   ///register [viewCubit]
  getIt.registerLazySingleton(() => ViewCubit());
}
