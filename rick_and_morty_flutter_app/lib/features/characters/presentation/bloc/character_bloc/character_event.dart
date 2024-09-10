import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCharacters extends CharacterEvent {}
