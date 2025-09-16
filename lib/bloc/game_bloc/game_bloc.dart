import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_event.dart';
import 'package:morty_guessr/bloc/game_bloc/game_state.dart';
import 'package:morty_guessr/bloc/network_bloc/network_bloc.dart';
import 'package:morty_guessr/constants/functions.dart';
import 'package:morty_guessr/databases/Scores/scores_database.dart';
import 'package:morty_guessr/models/character.dart';
import 'package:morty_guessr/models/score.dart';
import 'package:morty_guessr/services/audio_manager_service.dart';
import 'package:morty_guessr/services/check_internet_connection.dart';
import 'package:morty_guessr/services/fetch_character.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer? _timer;
  final NetworkBloc networkBloc;

  GameBloc({required this.networkBloc})
    : super(
        GameState(
          currentCharacter: Character(
            id: 0,
            name: "null",
            status: "null",
            location: "null",
            species: "null",
            image: "null",
          ),
          userGuess: null,
          hintShowed: false,
          timer: 60,
          settingsTimer: 60,
          currentScore: 0,
          isMusicOn: true,
          resetInput: false,
          wrongAnswerTrigger: 0,
          showAnwser: false,
          showEndgameModal: false,
          showNoInternetEndgameModal: false,
        ),
      ) {
    on<StartGame>((event, emit) async {
      _timer?.cancel();

      final newCharacter = await FetchCharacterService().getRandomCharacter();

      emit(
        state.copyWith(
          currentCharacter: newCharacter,
          resetInput: false,
          showEndgameModal: false,
          showNoInternetEndgameModal: false,
          timer: state.settingsTimer,
        ),
      );
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        add(TickTimer());
      });
    });

    on<GuessCharacter>((event, emit) {
      final guess = normalize(event.guess);
      final answer = normalize(state.currentCharacter.name);

      if (guess == answer) {
        if (state.currentScore < 999) {
          emit(state.copyWith(currentScore: state.currentScore + 1));
        }
        add(NextCharacter());
        add(ResetInputWidget());
        emit(state.copyWith(resetInput: true, timer: state.timer + 25));
      } else {
        emit(
          state.copyWith(
            resetInput: false,
            wrongAnswerTrigger: state.wrongAnswerTrigger + 1,
          ),
        );
      }
    });

    on<ShowHint>((event, emit) {
      emit(state.copyWith(hintShowed: true));
    });

    on<TickTimer>((event, emit) {
      if (state.timer > 0) {
        emit(state.copyWith(timer: state.timer - 1));
      } else {
        _timer?.cancel();
        add(ShowEndgameModal());
        add(ResetInputWidget());
      }
    });

    on<NextCharacter>((event, emit) async {
      final isOnline = await hasInternet();

      if (isOnline) {
        final newCharacter = await FetchCharacterService().getRandomCharacter();
        emit(
          state.copyWith(
            currentCharacter: newCharacter,
            userGuess: "",
            hintShowed: false,
            resetInput: false,
            showAnwser: false,
          ),
        );
      } else {
        add(ShowNoInternetEndgameModal());
        add(EndGame());
      }
    });

    on<SkipCharacter>((event, emit) async {
      final isOnline = await hasInternet();
      if (isOnline) {
        emit(state.copyWith(resetInput: true, showAnwser: true));
        await Future.delayed(const Duration(seconds: 2));

        final newCharacter = await FetchCharacterService().getRandomCharacter();
        emit(
          state.copyWith(
            currentCharacter: newCharacter,
            userGuess: "",
            hintShowed: false,
            resetInput: false,
            showAnwser: false,
          ),
        );
        emit(state.copyWith(timer: state.timer - 5));
      } else {
        add(ShowNoInternetEndgameModal());
        add(EndGame());
      }
    });

    on<ToggleMusic>((event, emit) {
      final newIsMusicOn = !state.isMusicOn;
      AudioManagerService.instance.toggle();
      emit(state.copyWith(isMusicOn: newIsMusicOn));
    });

    on<EndGame>((event, emit) async {
      final savedScore = state.currentScore;

      _timer?.cancel();
      if (savedScore != 0) {
        add(AddScoreToLeaderboard(savedScore, DateTime.now()));
      }

      emit(
        state.copyWith(
          currentCharacter: Character(
            id: 0,
            name: "null",
            status: "null",
            location: "null",
            species: "null",
            image: "null",
          ),
          userGuess: null,
          hintShowed: false,
          timer: state.settingsTimer,
          currentScore: 0,
          resetInput: false,
          wrongAnswerTrigger: 0,
          showAnwser: false,
          showEndgameModal: false,
          showNoInternetEndgameModal: false,
        ),
      );
    });

    on<ResetInputWidget>((event, emit) {
      emit(state.copyWith(resetInput: true));
    });

    on<AddScoreToLeaderboard>((event, emit) async {
      final db = ScoreDatabase.instance;
      await db.addScore(Score(points: event.score, date: event.date));
    });

    on<ShowEndgameModal>((event, emit) async {
      emit(state.copyWith(showEndgameModal: true));
    });

    on<ShowNoInternetEndgameModal>((event, emit) async {
      emit(state.copyWith(showNoInternetEndgameModal: true));
    });

    on<ChangeInitialTimer>((event, emit) async {
      switch (event.settingsTimer) {
        case 30:
          {
            emit(state.copyWith(settingsTimer: 60));
            break;
          }
        case 60:
          {
            emit(state.copyWith(settingsTimer: 90));
            break;
          }
        case 90:
          {
            emit(state.copyWith(settingsTimer: 30));
            break;
          }
      }
    });
  }
}

