import 'dart:async';
import 'dart:convert';

import '../../models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//shared preferences key
final String cachedKey = 'CACHED_CHARACTER';

abstract class LocalDataSource {
  ///method that gets the last [CharacterModel] that was cached
  /// if no data is available, throw a [CachedException]
  Future<List<CharacterModel>> getCachedCharacters();

  /// Saves a list of [CharacterModel] to local storage.
  Future<void> cacheCharacters(List<CharacterModel> charactersToCache);

  /// clears the cached character data
  Future<void> clearCachedCharacters();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferencesAsync asyncPrefs;

  LocalDataSourceImpl({required this.asyncPrefs});

  @override
  Future<List<CharacterModel>> getCachedCharacters() async {
    // Get the cached JSON string from SharedPreferences
    final jsonString = await asyncPrefs.getString(cachedKey);

    if (jsonString != null) {
      // Convert the JSON string back into a List of dynamic objects
      final List<dynamic> jsonData = json.decode(jsonString);
      // Map the list of dynamic objects to a List of CharacterModel objects
      final List<CharacterModel> characters = jsonData
          .map((characterJson) => CharacterModel.fromJson(characterJson))
          .toList();
      // Return the cached list of characters
      return Future.value(characters);
    } else {
      // If no cached data is found, throw an exception
      throw Exception('No cached characters found');
    }
  }

  @override
  Future<void> cacheCharacters(List<CharacterModel> charactersToCache) {
    // Convert the list of CharacterModel to JSON and save it as a string
    final List<Map<String, dynamic>> charactersJson = charactersToCache
        .map((characterModel) => characterModel.toJson())
        .toList();
    final jsonString = json.encode(charactersJson);
    return asyncPrefs.setString(cachedKey, jsonString);
  }

  @override
  Future<void> clearCachedCharacters() {
    return asyncPrefs.remove(cachedKey);
  }
}
