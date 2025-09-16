import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:morty_guessr/screens/lobbyscreen/lobby_screen.dart';
import 'package:page_transition/page_transition.dart';

void goToLobby(BuildContext context) {
  // zamknij dialog (jeśli jest)
  Navigator.of(context, rootNavigator: true).pop();

  // usuń focus z dowolnego widgetu
  FocusManager.instance.primaryFocus?.unfocus();

  // wymuś ukrycie klawiatury na warstwie platformy
  SystemChannels.textInput.invokeMethod('TextInput.hide');

  // teraz nawiguj
  Navigator.pushReplacement(
    context,
    // PageRouteBuilder(
    //   pageBuilder: (context, animation, secondaryAnimation) => const LobbyScreen(),
    //   transitionDuration: Duration.zero,
    // ),
    PageTransition(type: PageTransitionType.fade, child: const LobbyScreen()),
  );
}

String normalize(String s) {
  return s
      .toLowerCase()
      .trim()
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(RegExp(r'[‘’]'), "'");
}
