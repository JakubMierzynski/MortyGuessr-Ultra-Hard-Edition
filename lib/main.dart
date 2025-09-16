import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morty_guessr/bloc/character_bloc/character_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/leaderboard_bloc/leaderboard_bloc.dart';
import 'package:morty_guessr/bloc/network_bloc/network_bloc.dart';
import 'package:morty_guessr/databases/Scores/scores_database.dart';
import 'package:morty_guessr/screens/lobbyscreen/lobby_screen.dart';
import 'package:morty_guessr/services/audio_manager_service.dart';
import 'package:morty_guessr/services/fetch_character.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScoreDatabase.instance.clearScores();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AudioManagerService.instance.init();

    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterBloc>(
          create: (context) =>
              CharacterBloc(fetchCharacterService: FetchCharacterService()),
        ),
        BlocProvider<NetworkBloc>(create: (context) => NetworkBloc()),

        BlocProvider<GameBloc>(
          create: (context) => GameBloc(networkBloc: NetworkBloc()),
        ),
        BlocProvider<LeaderboardBloc>(
          create: (context) => LeaderboardBloc(ScoreDatabase.instance),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          title: 'MortyGuessr',
          theme: ThemeData(
            textTheme: GoogleFonts.silkscreenTextTheme(),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            useMaterial3: true,
          ),
          home: const LobbyScreen(),
        ),
      ),
    );
  }
}
