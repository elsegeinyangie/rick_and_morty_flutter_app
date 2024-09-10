import '../../models/character_model.dart';
import '../../../domain/entities/character_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class RemoteDataSource {
  //method to fetch data from api
  Future<List<CharacterModel>> fetchAllCharacters();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> fetchAllCharacters() async {
    List<CharacterModel> characters = [];
    final response = await client
        .get(Uri.parse('https://rickandmortyapi.com/api/character'));

    if (response.statusCode == 200) {
      ///if api request to get character is successful,
      ///parse the response and return a character object
      final data = json.decode(response.body);
      final characterList = (data['results'] as List)
          .map((characterData) => CharacterModel.fromJson(characterData))
          .toList();

      characters.addAll(characterList);

      return characters;
    } else {
      throw Exception('Failed to fetch user from API');
    }
  }
}
