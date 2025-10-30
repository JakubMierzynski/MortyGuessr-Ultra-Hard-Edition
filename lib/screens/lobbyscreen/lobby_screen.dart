import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/network_bloc/network_bloc.dart';
import 'package:morty_guessr/bloc/network_bloc/network_state.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/screens/leaderboard/leaderboard_screen.dart';
import 'package:morty_guessr/services/check_internet_connection.dart';
import 'package:morty_guessr/screens/loadingscreen/loading_screen.dart';
import 'package:morty_guessr/widgets/lobby_button_container_widget.dart';
import 'package:morty_guessr/widgets/no_internet_widget.dart';
import 'package:morty_guessr/widgets/shake_text.dart';
import 'package:morty_guessr/widgets/show_info_widget.dart';
import 'package:morty_guessr/widgets/show_settings_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LobbyScreenState();
  }
}

class _LobbyScreenState extends State<LobbyScreen>
    with TickerProviderStateMixin {
  bool _imagesPrecached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_imagesPrecached) {
      precacheImage(
        const AssetImage("assets/images/try_leader_neon.png"),
        context,
      );
      precacheImage(
        const AssetImage("assets/images/poker_face_neon.png"),
        context,
      );
      precacheImage(
        const AssetImage("assets/images/not_happy_face_neon.png"),
        context,
      );
      precacheImage(const AssetImage("assets/images/morty_icon.png"), context);
      precacheImage(
        const AssetImage("assets/images/happy_face_neon.png"),
        context,
      );
      precacheImage(
        const AssetImage("assets/images/cry_face_neon.png"),
        context,
      );

      _imagesPrecached = true;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        height: 100.r,
                        width: 250.r,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: fontColor, width: 3.r),
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [boxShadow],
                        ),
                        child: Center(
                          child: TapDebouncer(
                            cooldown: const Duration(milliseconds: 2000),
                            onTap: () async {
                              // alway check check if online before starting
                              final isOnline = await hasInternet();

                              if (isOnline) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const LoadingScreen(),
                                  ),
                                );
                              } else {
                                if (context.mounted) {
                                  noInternetConnectionWidget(context);
                                }
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
                                        fontSize: 25.r,
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
                      SizedBox(height: 45.r),
                      const LobbyButtonContainerWidget(
                        buttonText: "LEADERBOARD",
                        toPage: LeaderboardScreen(),
                      ),
                      SizedBox(height: 45.r),
                      LobbyButtonContainerWidget(
                        buttonText: "SETTINGS",
                        dialogFunc: () {
                          showSettingsWidget(context);
                        },
                        delay: 0,
                      ),
                      SizedBox(height: 30.r),
                      LobbyButtonContainerWidget(
                        buttonText: "?",
                        width: 60.r,
                        height: 60.r,
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
