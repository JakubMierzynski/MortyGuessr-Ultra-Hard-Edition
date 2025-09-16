import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_event.dart';
import 'package:morty_guessr/bloc/game_bloc/game_state.dart';
import 'package:morty_guessr/bloc/network_bloc/network_bloc.dart';
import 'package:morty_guessr/bloc/network_bloc/network_event.dart';
import 'package:morty_guessr/bloc/network_bloc/network_state.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonContainerWidget extends StatelessWidget {
  final icon;
  final buttonText;
  final GameEvent? gameEvent;
  final NetworkEvent? networkEvent;
  final Function? actionFunction;
  final double? height;
  final double? width;
  final int? delay;

  const ButtonContainerWidget({
    super.key,
    this.icon,
    this.buttonText,
    this.gameEvent,
    this.networkEvent,
    this.actionFunction,
    this.height,
    this.width,
    this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = screenHeight(context) < 700;

    if (gameEvent != null && networkEvent != null) {
      // CAN'T PUT BOTH AT SAME TIME
      return const SizedBox.shrink();
    } else if (gameEvent != null) {
      final gameBloc = context.read<GameBloc>();
      return BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Container(
            height: (height != null)
                ? height
                : isSmallScreen
                ? 68.r
                : 55.r,
            width: (width != null)
                ? width
                : isSmallScreen
                ? 68.r
                : 55.r,
            decoration: BoxDecoration(
              boxShadow: [boxShadow],
              border: Border.all(
                color: fontColor, // kolor obwódki
                width: 2.r,
              ),

              borderRadius: BorderRadius.circular(
                8.r,
              ), // lekko zaokrąglone rogi
            ),
            child: Center(
              child: TapDebouncer(
                cooldown: (delay == null)
                    ? const Duration(milliseconds: 3000)
                    : Duration(milliseconds: delay!),
                onTap: () async {
                  await actionFunction?.call();
                  gameBloc.add(gameEvent!);
                },
                builder: (context, onTap) {
                  return icon != null
                      ? IconButton(onPressed: onTap, icon: icon)
                      : TextButton(
                          onPressed: onTap,
                          child: Text(
                            buttonText.toString(),
                            style: TextStyle(color: fontColor, fontSize: 20.r),
                          ),
                        );
                },
              ),
            ),
          );
        },
      );
    } else if (networkEvent != null) {
      final networkBloc = context.read<NetworkBloc>();
      return BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, state) {
          return Container(
            height: (height != null)
                ? height
                : isSmallScreen
                ? 68.r
                : 55.r,
            width: (width != null)
                ? width
                : isSmallScreen
                ? 68.r
                : 55.r,
            decoration: BoxDecoration(
              boxShadow: [boxShadow],
              border: Border.all(
                color: fontColor, // kolor obwódki
                width: 2.r,
              ),

              borderRadius: BorderRadius.circular(
                8.r,
              ), // lekko zaokrąglone rogi
            ),
            child: Center(
              child: TapDebouncer(
                cooldown: (delay == null)
                    ? const Duration(milliseconds: 3000)
                    : Duration(milliseconds: delay!),
                onTap: () async {
                  await actionFunction?.call();
                  networkBloc.add(networkEvent!);
                },
                builder: (context, onTap) {
                  return icon != null
                      ? IconButton(onPressed: onTap, icon: icon)
                      : TextButton(
                          onPressed: onTap,
                          child: Text(
                            buttonText.toString(),
                            style: TextStyle(
                              color: fontColor,
                              fontSize: isSmallScreen ? 25.r : 20.r,
                            ),
                          ),
                        );
                },
              ),
            ),
          );
        },
      );
    } else {
      //Beware that button without event && function parameter will do () {}
      return Container(
        height: (height != null)
            ? height
            : isSmallScreen
            ? 68.r
            : 55.r,
        width: (width != null)
            ? width
            : isSmallScreen
            ? 68.r
            : 55.r,
        decoration: BoxDecoration(
          boxShadow: [boxShadow],
          border: Border.all(color: fontColor, width: 2.r),

          borderRadius: BorderRadius.circular(8.r), // lekko zaokrąglone rogi
        ),
        child: Center(
          child: TapDebouncer(
            cooldown: (delay == null)
                ? const Duration(milliseconds: 3000)
                : Duration(milliseconds: delay!),
            onTap: () async {
              await actionFunction?.call();
            },
            builder: (context, onTap) {
              return icon != null
                  ? IconButton(onPressed: onTap, icon: icon)
                  : TextButton(
                      onPressed: onTap,
                      child: Text(
                        buttonText.toString(),
                        style: TextStyle(color: fontColor, fontSize: 20.r),
                      ),
                    );
            },
          ),
        ),
      );
    }
  }
}
