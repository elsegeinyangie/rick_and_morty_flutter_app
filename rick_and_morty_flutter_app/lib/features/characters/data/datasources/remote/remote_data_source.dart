import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class RemoteDataSource {
  //method to fetch data from api
  Future<CharacterEntity> fetchRemoteData();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<CharacterEntity> fetchRemoteData() async {
    final response = await client
        .get(Uri.parse('https://rickandmortyapi.com/api/character'));

    if (response.statusCode == 200) {
      ///if api request to get character is successful
      ///parse the response and return a character object
      final data = json.decode(response.body);
      return CharacterEntity(
          id: data['id'],
          name: data['name'],
          status: data['status'],
          species: data['species'],
          gender: data['gender'],
          location: data['location'],
          image: data['image'],
          episodes: data['episodes']);
    } else {
      throw Exception('Failed to fetch user from API');
    }
  }
}
