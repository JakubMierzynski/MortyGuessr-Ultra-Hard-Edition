import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/network_bloc/network_bloc.dart';
import 'package:morty_guessr/bloc/network_bloc/network_event.dart';
import 'package:morty_guessr/bloc/network_bloc/network_state.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/widgets/button_container_widget.dart';
import 'package:morty_guessr/widgets/snack_no_internet.dart';

void noInternetConnectionWidget(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: fontColor, width: 2),
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
            actionsAlignment: MainAxisAlignment.center,
            title: Text(
              "NO INTERNET CONNECTION",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: fontColor,
                color: fontColor,
              ),
            ),
            content: SizedBox(
              height: 250,
              width: 250,
              child: Image.asset("assets/images/no_internet.png"),
            ),
            actions: [
              ButtonContainerWidget(
                buttonText: "Try again",
                width: 200,
                height: 60,
                delay: 2000,
                actionFunction: () {
                  noInternetSnackbar(context);
                  Navigator.of(context).pop();
                },
                networkEvent: CheckNetwork(),
              ),
            ],
          );
        },
      );
    },
  );
}
