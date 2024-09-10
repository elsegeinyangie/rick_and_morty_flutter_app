import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';


abstract class CharacterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharacterEntity> characters;

  CharacterLoaded({required this.characters});

  @override
  List<Object?> get props => [characters];
}

class CharacterError extends CharacterState {
  final String message;

  CharacterError({required this.message});

  @override
  List<Object?> get props => [message];
}