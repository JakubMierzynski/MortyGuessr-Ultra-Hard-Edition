import 'dart:math';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_event.dart';
import 'package:morty_guessr/constants/loading_texts.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/screens/gamescreen/game_screen.dart';
import 'package:page_transition/page_transition.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  final loadingText = loadingTexts[Random().nextInt(loadingTexts.length)];
  final randomInt = Random().nextInt(2) + 1;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // czas ładowania paska
    )..forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(
      const AssetImage("assets/images/poker_face_neon.png"),
      context,
    ).then((_) {
      _startLoading();
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) context.read<GameBloc>().add(StartGame());
    });
  }

  Future<void> _startLoading() async {
    await _progressController.forward().orCancel;

    if (!mounted) return;
    // przejście do GameScreen
    Navigator.pushReplacement(
      context,
      PageTransition(type: PageTransitionType.fade, child: const GameScreen()),
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    (randomInt % 2 == 0)
                        ? "assets/animations/rick.json"
                        : "assets/animations/morty_dancing.json",
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    loadingText,
                    style: TextStyle(color: fontColor, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: 300,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent, width: 2),
                    ),
                    child: AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) {
                        return FractionallySizedBox(
                          widthFactor: _progressController.value,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(color: fontColor),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, child) {
                      final percent = (_progressController.value * 100).ceil();
                      return Text(
                        "$percent%",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(color: fontColor, blurRadius: 4)],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
