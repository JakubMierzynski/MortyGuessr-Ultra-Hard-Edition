import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_event.dart';
import 'package:morty_guessr/bloc/game_bloc/game_state.dart';
import 'package:morty_guessr/constants/functions.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/widgets/button_container_widget.dart';
import 'package:morty_guessr/widgets/guess_sugestions_widget.dart';
import 'package:morty_guessr/widgets/no_internet_endgame_moda.dart';
import 'package:morty_guessr/widgets/show_endgame_widget.dart';
import 'package:morty_guessr/widgets/show_hint_widget.dart';
import 'package:morty_guessr/widgets/timer_bar_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final gameBloc = context.read<GameBloc>();

    return BlocListener<GameBloc, GameState>(
      listenWhen: (previous, current) =>
          previous.showEndgameModal != current.showEndgameModal ||
          previous.showNoInternetEndgameModal !=
              current.showNoInternetEndgameModal,

      listener: (context, state) {
        if (state.showEndgameModal == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showEndgameCenteredModal(context);
          });
        }

        if (state.showNoInternetEndgameModal == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showNoInternetEndgameModal(context);
          });
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true, // pozwala body nachodzić pod AppBar

        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent, // transparentne tło
          elevation: 0,
          title: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<GameBloc, GameState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        goToLobby(context);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          gameBloc.add(EndGame());
                        });
                      },
                      icon: Icon(Icons.home, color: fontColor),
                    );
                  },
                ),
                Column(
                  children: [
                    Text(
                      "MortyGuessr",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: fontColor,
                      ),
                    ),
                    Text(
                      "(ULTRA HARD EDITION)",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.normal,
                        color: fontColor,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<GameBloc, GameState>(
                  builder: (context, state) {
                    final isMusicOn = state.isMusicOn;

                    return IconButton(
                      onPressed: () {
                        gameBloc.add(ToggleMusic());
                      },
                      icon: Icon(
                        isMusicOn ? Icons.volume_up : Icons.volume_off,
                        color: fontColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/background.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            AnimatedBackground(
              behaviour: RandomParticleBehaviour(options: particleOptions),
              vsync: this,
              child: BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  final character = state.currentCharacter;

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
                    child: Column(
                      children: [
                        SizedBox(height: 110),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 200,
                                    child: Column(
                                      children: [
                                        Text(
                                          "SCORE",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: fontColor,
                                          ),
                                        ),
                                        Text(
                                          "${state.currentScore}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: fontColor,
                                          ),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: character.image == "null"
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  // boxShadow: [boxShadow],
                                                ),
                                                child: Image.asset(
                                                  "assets/images/poker_face_neon.png",
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [boxShadow],
                                                  border: Border.all(
                                                    color: fontColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    character.image,
                                                    width: 200,
                                                    height: 200,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    height: 200,
                                    child: Column(
                                      children: [
                                        Text(
                                          "TIME",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: fontColor,
                                          ),
                                        ),
                                        BlocBuilder<GameBloc, GameState>(
                                          builder: (context, state) {
                                            return TimerBar(timer: state.timer);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const SizedBox(height: 10),
                                  BlocBuilder<GameBloc, GameState>(
                                    builder: (context, state) {
                                      return state.showAnwser == true
                                          ? SizedBox(
                                              width: 450,
                                              child: Text(
                                                character.name,
                                                softWrap: true,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: fontColor,
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink();
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    character.name,
                                    style: TextStyle(color: fontColor),
                                  ),
                                  Row(
                                    children: [
                                      ButtonContainerWidget(
                                        delay: 0,
                                        icon: Icon(
                                          Icons.lightbulb,
                                          color: fontColor,
                                        ),
                                        gameEvent: ShowHint(),
                                        actionFunction: () {
                                          showHintCenteredModal(context);
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      const Flexible(
                                        child: GuessInputWidget2(),
                                      ),
                                      const SizedBox(width: 10),
                                      ButtonContainerWidget(
                                        icon: Icon(
                                          Icons.fast_forward,
                                          color: fontColor,
                                        ),
                                        gameEvent: SkipCharacter(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
