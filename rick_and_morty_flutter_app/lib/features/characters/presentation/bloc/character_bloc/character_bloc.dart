import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty_flutter_app/core/error/exceptions.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/entities/character_entity.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/usecases/character_usecase.dart';
part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  //initialize
  final CharacterUsecase characterUsecase;
  CharacterBloc({required this.characterUsecase}) : super(CharacterInitial()) {
    on<CharacterEvent>((event, emit) {
      //listen to incoming events and yield new states (events to states func)
      Stream<CharacterState> eventToStateConvertion(CharacterEvent) async* {
        //when fetching user data, start by showing a loading state
        if (event is FetchCharacter) {
          yield CharacterLoading();
          //try to get the character using the usecase using the execute function
          try {
            final character = await characterUsecase.execute();
          } catch (e) {
            throw CharacterException(
                'Failed to fetch character data through excute(): ${e.toString()}');
          }
        }
      }

    });
  }
}
