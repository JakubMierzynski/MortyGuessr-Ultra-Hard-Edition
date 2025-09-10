import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/character_bloc/character_event.dart';
import 'package:morty_guessr/bloc/character_bloc/character_state.dart';
import 'package:morty_guessr/services/fetch_character.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final FetchCharacterService fetchCharacterService;

  CharacterBloc({required this.fetchCharacterService}) : super(CharacterState()) {
    on<FetchCharacter>(
      (event, emit) async {
        try {
          final character = await fetchCharacterService.getRandomCharacter();
          emit(CharacterState(currentCharacter: character));
        } catch (_) {
          emit(CharacterState(currentCharacter: null));
        }
      },
    );
  }
}
