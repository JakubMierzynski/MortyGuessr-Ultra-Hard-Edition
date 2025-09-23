import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/constants/functions.dart';
import 'package:morty_guessr/databases/Scores/scores_database.dart';
import 'package:morty_guessr/widgets/circle_container.dart';
import 'package:morty_guessr/widgets/shake_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final isSmallScreen = screenHeight(context) < 700;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black12,

        title: Text(
          "TOP SCORES",
          style: TextStyle(
            fontSize: 40.r,
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
              "assets/images/background.png",
              fit: BoxFit.fitHeight,
            ),
          ),

          AnimatedBackground(
            behaviour: RandomParticleBehaviour(options: particleOptions),
            vsync: this,

            child: Padding(
              padding: isSmallScreen
                  ? EdgeInsets.fromLTRB(40.r, 20.r, 40.r, 40.r)
                  : EdgeInsets.fromLTRB(40.r, 20.r, 40.r, 70.r),
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
                              SizedBox(height: 150.r),
                              const Image(
                                image: AssetImage(
                                  "assets/images/try_leader_neon.png",
                                ),
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 50.r),
                              Text(
                                "No scores yet!",
                                style: TextStyle(
                                  color: fontColor,
                                  fontSize: 30.r,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: isSmallScreen ? 30.r : 100.r),
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
                                  padding: EdgeInsets.symmetric(vertical: 20.r),
                                  child: (index + 1 == 1)
                                      ? SizedBox(
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              DecoratedBox(
                                                decoration: BoxDecoration(
                                                  boxShadow: [boxShadow],
                                                  border: Border.all(
                                                    width: 2.r,
                                                    color: fontColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8.r,
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 20.r,
                                                    vertical: 8.r,
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
                                                            color: const Color(
                                                              0xFFFFD700,
                                                            ),
                                                            size: 35.r,
                                                          ),
                                                          SizedBox(width: 6.r),
                                                          SizedBox(
                                                            child: LottieBuilder.asset(
                                                              frameRate:
                                                                  const FrameRate(
                                                                    8,
                                                                  ),
                                                              "assets/animations/Fire.json",
                                                              height: 45.r,
                                                              width: 45.r,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      ShakeText(
                                                        text: score.points
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 50.r,
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
                                                top: -40
                                                    .r, // dostosuj pozycję w pionie
                                                right: -25
                                                    .r, // dostosuj pozycję w poziomie
                                                child: Image.asset(
                                                  'assets/images/morty_icon.png',
                                                  width:
                                                      80.r, // szerokość obrazu
                                                  height:
                                                      80.r, // wysokość obrazu
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            SizedBox(
                                              width: isSmallScreen
                                                  ? 250.r
                                                  : 210.r,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  boxShadow: [boxShadow],
                                                  border: Border.all(
                                                    width: 2.r,
                                                    color: fontColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8.r,
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 20.r,
                                                    vertical: 8.r,
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
                                                        style: TextStyle(
                                                          fontSize: 40.r,
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
                      width: 150.r,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [boxShadow],
                          border: Border.all(width: 2.r, color: fontColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: IconButton(
                          onPressed: () {
                            goToLobby(context);
                          },
                          icon: Icon(Icons.home, color: fontColor, size: 30.r),
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
