import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_event.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/widgets/shake_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class LobbyButtonContainerWidget extends StatelessWidget {
  final GameEvent? event;
  final Function? dialogFunc;
  final String buttonText;
  final Widget? toPage;
  final int? delay;
  final double? width;
  final double? height;

  const LobbyButtonContainerWidget({
    super.key,
    this.event,
    this.dialogFunc,
    this.toPage,
    this.delay,
    this.width,
    this.height,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final gameBloc = context.read<GameBloc>();

    return Container(
      height: (height != null) ? height : 100,
      width: (width != null) ? width : 250,
      decoration: BoxDecoration(
        color: Colors.black, // czarne wypełnienie
        border: Border.all(
          color: fontColor, // zielony neonowy border
          width: 3,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [boxShadow],
      ),
      child: Center(
        child: TapDebouncer(
          cooldown: (delay != null)
              ? Duration(milliseconds: delay!)
              : const Duration(milliseconds: 3000),
          onTap: () async {
            if (event != null) {
              gameBloc.add(event!);
            }

            if (toPage != null) {
              Navigator.push(
                context,
                PageTransition(type: PageTransitionType.fade, child: toPage!),
                // MaterialPageRoute(builder: (_) => toPage!),
              );
            } else if (dialogFunc != null) {
              dialogFunc!();
            } else {
              SizedBox.shrink();
              // Does nothing. Need dialogFunc or toPage parameter
            }
          },
          builder: (context, onTap) {
            return TextButton(
              style: TextButton.styleFrom(
                foregroundColor: fontColor,
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: onTap,
              child: ShakeText(text: buttonText),
            );
          },
        ),
      ),
    );
  }
}
