part of 'character_bloc.dart';

@immutable
sealed class CharacterEvent {}

class FetchCharacter extends CharacterEvent{}
