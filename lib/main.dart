import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: MaterialApp(
        title: 'MortyGuessr',
        theme: ThemeData(
          // ogólny font dla całej aplikacji
          textTheme: GoogleFonts.silkscreenTextTheme(),

          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 0, 0),
          ),
          useMaterial3: true,
        ),
        home: const LobbyScreen(),
      ),
    );
  }
}
