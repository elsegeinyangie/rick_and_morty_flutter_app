import 'dart:async';
import 'dart:convert';

import 'package:rick_and_morty_flutter_app/features/characters/data/models/character_model.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

//shared preferences key
final String cachedKey = 'CACHED_CHARACTER';

abstract class LocalDataSource {
  ///method that gets the last [CharacterModel] that was cached
  /// if no data is available, throw a [CachedException]
  Future<CharacterModel> getCachedData();

  /// saves [CharacterModel] to [Local Storage]
  Future<void> cacheCharacter(CharacterModel characterToCache);

  /// clears the cached character data
  Future<void> clearCachedCharacter();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  @override
  Future<CharacterModel> getCachedData() {
    final jsonString = asyncPrefs.getString(cachedKey);
    final CharacterModel characterModel;

    if (jsonString == true) {
      //convert the json back to CharacterModel
      return Future.value(
          CharacterModel.fromJson(json.decode(jsonString as String)));
    } else {
      throw Exception('No cached character found');
    }
  }

  @override
  Future<void> cacheCharacter(CharacterModel characterToCache) {
    // Convert the UserModel into a JSON string and save it
    final jsonString = json.encode(characterToCache.toJson());
    return asyncPrefs.setString(cachedKey, jsonString);
  }

  @override
  Future<void> clearCachedCharacter() {
    return asyncPrefs.remove(cachedKey);
  }
}
