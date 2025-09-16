import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_event.dart';
import 'package:morty_guessr/bloc/game_bloc/game_state.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/widgets/shake_widget.dart';
import 'package:morty_guessr/services/fetch_character.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuessInputWidget2 extends StatefulWidget {
  const GuessInputWidget2({super.key});

  @override
  State<StatefulWidget> createState() => _GuessInputWidget2State();
}

class _GuessInputWidget2State extends State<GuessInputWidget2> {
  TextEditingController? _taController;
  FocusNode? _taFocusNode;
  final GlobalKey<ShakeWidgetState> _shakeKey = GlobalKey<ShakeWidgetState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameBloc = context.read<GameBloc>();

    return Column(
      children: [
        // Listener do resetInput
        BlocListener<GameBloc, GameState>(
          listenWhen: (previous, current) => current.resetInput,
          listener: (context, state) {
            _taController?.clear();
            _taFocusNode?.requestFocus();
          },
          child: const SizedBox.shrink(),
        ),
        // Listener do shake
        BlocListener<GameBloc, GameState>(
          listenWhen: (previous, current) =>
              previous.wrongAnswerTrigger != current.wrongAnswerTrigger,
          listener: (context, state) {
            _shakeKey.currentState?.shake();
            HapticFeedback.vibrate();
          },
          child: TypeAheadField<String>(
            errorBuilder: (context, error) => const Center(
              child: Text('Catastrophic Error!!', textAlign: TextAlign.center),
            ),
            emptyBuilder: (context) =>
                const Text('Empty builder', textAlign: TextAlign.center),
            hideOnLoading: true,
            hideOnEmpty: true,
            constraints: BoxConstraints(maxHeight: 120.r),
            suggestionsCallback: (input) async {
              final all = await FetchCharacterService().getAllCharacters(input);

              if (input.isEmpty) return <String>[];

              return all
                  .where(
                    (name) => name.toLowerCase().contains(input.toLowerCase()),
                  )
                  .toList();
            },
            decorationBuilder: (context, child) {
              return Container(
                decoration: BoxDecoration(boxShadow: [boxShadow]),
                child: Material(
                  surfaceTintColor: Colors.black87,
                  color: fontColor.withOpacity(0.6),
                  type: MaterialType.card,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8.r),
                  child: child,
                ),
              );
            },
            builder: (context, controller, focusNode) {
              _taController = controller;
              _taFocusNode = focusNode;
              return ShakeWidget(
                key: _shakeKey,
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: true,
                  keyboardType: TextInputType.visiblePassword,
                  autocorrect: false,
                  enableSuggestions: false,
                  enableInteractiveSelection: false,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: fontColor),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: fontColor),
                    helperStyle: const TextStyle(color: fontColor),
                    hintStyle: const  TextStyle(color: fontColor),
                    hintText: "character name...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: fontColor, width: 2.r),
                    ),
                  ),
                  onSubmitted: (value) {
                    gameBloc.add(GuessCharacter(value));
                    _taFocusNode?.requestFocus();
                  },
                ),
              );
            },
            itemBuilder: (context, name) {
              return ListTile(title: Text(name));
            },
            onSelected: (value) {
              gameBloc.add(GuessCharacter(value));
              FocusScope.of(context).requestFocus(_taFocusNode);
            },
          ),
        ),
      ],
    );
  }
}
