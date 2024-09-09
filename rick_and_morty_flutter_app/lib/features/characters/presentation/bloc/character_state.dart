part of 'character_bloc.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}

/// state when the app is [loading data]
class CharacterLoading extends CharacterState {}

/// state when the app has [successfully loaded data]
class CharacterLoaded extends CharacterState {
  final CharacterEntity characterEntity;
  CharacterLoaded({required this.characterEntity});
}


/// state whne there is an [error loading data]
class CharacterError extends CharacterState {
  final String message;
  CharacterError({required this.message});
}
