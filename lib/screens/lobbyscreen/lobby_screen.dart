import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_event.dart';
import 'package:morty_guessr/bloc/network_bloc/network_bloc.dart';
import 'package:morty_guessr/bloc/network_bloc/network_state.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/screens/gamescreen/game_screen.dart';
import 'package:morty_guessr/screens/leaderboard/leaderboard_screen.dart';
import 'package:morty_guessr/services/check_internet_connection.dart';
import 'package:morty_guessr/widgets/loading_screen.dart';
import 'package:morty_guessr/widgets/lobby_button_container_widget.dart';
import 'package:morty_guessr/widgets/no_internet_widget.dart';
import 'package:morty_guessr/widgets/shake_text.dart';
import 'package:morty_guessr/widgets/show_info_widget.dart';
import 'package:morty_guessr/widgets/show_settings_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LobbyScreenState();
  }
}

class _LobbyScreenState extends State<LobbyScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final gameBloc = context.read<GameBloc>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black12,

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
            child: BlocBuilder<NetworkBloc, NetworkState>(
              builder: (context, state) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/new_title.png",
                        fit: BoxFit.contain,
                      ),
                      Container(
                        height: 100,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: fontColor, width: 3),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [boxShadow],
                        ),
                        child: Center(
                          child: TapDebouncer(
                            cooldown: const Duration(milliseconds: 2000),
                            onTap: () async {
                              // alway check check if online before starting
                              final isOnline = await hasInternet();

                              if (isOnline) {
                                // gameBloc.add(StartGame());
                                // Navigator.push(
                                //   context,
                                //   PageTransition(
                                //     type: PageTransitionType.fade,
                                //     child: const GameScreen(),
                                //   ),
                                // );

                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const LoadingScreen(),
                                  ),
                                );
                              } else {
                                noInternetConnectionWidget(context);
                              }
                            },
                            builder: (context, onTap) {
                              return TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: fontColor,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                onPressed: onTap ?? () {},
                                child: const ShakeText(text: "START GAME"),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 45),
                      LobbyButtonContainerWidget(
                        buttonText: "LEADERBOARD",
                        toPage: LeaderboardScreen(),
                      ),
                      SizedBox(height: 45),
                      LobbyButtonContainerWidget(
                        buttonText: "SETTINGS",
                        dialogFunc: () {
                          showSettingsWidget(context);
                        },
                        delay: 0,
                      ),
                      SizedBox(height: 30),
                      LobbyButtonContainerWidget(
                        buttonText: "?",
                        width: 60,
                        height: 60,
                        delay: 0,
                        dialogFunc: () {
                          showInfoCenteredModal(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
