import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/constants/functions.dart';
import 'package:morty_guessr/databases/Scores/scores_database.dart';
import 'package:morty_guessr/widgets/circle_container.dart';
import 'package:morty_guessr/widgets/shake_text.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LeaderboardScreen();
  }
}

class _LeaderboardScreen extends State<LeaderboardScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final fetchScores = ScoreDatabase.instance.fetchScores();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "TOP SCORES",
          style: TextStyle(
            fontSize: 40,
            color: fontColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background2.png",
              fit: BoxFit.fitHeight,
            ),
          ),

          AnimatedBackground(
            behaviour: RandomParticleBehaviour(
              options: particleOptions
            ),
            vsync: this,

            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: fetchScores,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text("Error while fetching scores");
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Column(
                            children: [
                              SizedBox(height: 150),
                              Image(
                                image: AssetImage(
                                  "assets/images/try_leader_neon.png",
                                ),
                              ),
                              SizedBox(height: 50),
                              Text(
                                "No scores yet!",
                                style: TextStyle(
                                  color: fontColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 100),
                            ],
                          );
                        } else {
                          final snapshotScores = snapshot.data!;
                          final listOfTopScores = snapshotScores
                              .map(
                                (score) => (
                                  Text(score.points.toString()),
                                  Text(score.formattedDate),
                                ),
                              )
                              .toList();

                          return Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listOfTopScores.length,
                              itemBuilder: (context, index) {
                                final score = snapshotScores[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                  ),
                                  child: (index + 1 == 1)
                                      ? SizedBox(
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              DecoratedBox(
                                                decoration: BoxDecoration(
                                                  boxShadow: [boxShadow],
                                                  border: Border.all(
                                                    width: 2,
                                                    color: fontColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 8,
                                                      ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          FaIcon(
                                                            FontAwesomeIcons
                                                                .trophy,
                                                            color: Color(
                                                              0xFFFFD700,
                                                            ),
                                                            size: 35,
                                                          ),
                                                          SizedBox(width: 6),
                                                          SizedBox(
                                                            child: LottieBuilder.asset(
                                                              frameRate:
                                                                  FrameRate(8),
                                                              "assets/animations/Fire.json",
                                                              height: 45,
                                                              width: 45,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      ShakeText(
                                                        text: score.points
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 50,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                        pauseDuration: 2000,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:
                                                    -40, // dostosuj pozycję w pionie
                                                right:
                                                    -25, // dostosuj pozycję w poziomie
                                                child: Image.asset(
                                                  'assets/images/morty_icon.png',
                                                  width: 80, // szerokość obrazu
                                                  height: 80, // wysokość obrazu
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            SizedBox(
                                              width: 210,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  boxShadow: [boxShadow],
                                                  border: Border.all(
                                                    width: 2,
                                                    color: fontColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 8,
                                                      ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CircleContainer(
                                                        index: index,
                                                      ),
                                                      Text(
                                                        score.points.toString(),
                                                        style: const TextStyle(
                                                          fontSize: 40,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      width: 150,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [boxShadow],
                          border: Border.all(width: 2, color: fontColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {
                            goToLobby(context);
                          },
                          icon: Icon(Icons.home, color: fontColor, size: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
