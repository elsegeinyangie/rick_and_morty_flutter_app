import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_flutter_app/features/characters/domain/usecases/character_usecase.dart';
import '../../../domain/entities/character_entity.dart';
import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterUsecase characterUsecase;

  CharacterBloc({required this.characterUsecase}) : super(CharacterLoading()) {
    on<FetchCharacters>(_onFetchCharacters);
  }
  
  Future<void> _onFetchCharacters(
      FetchCharacters event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());
    try {
      final characters = await characterUsecase.execute();
      emit(CharacterLoaded(characters: characters));
    } catch (e) {
      emit(CharacterError(message: e.toString()));
    }
  }
}
