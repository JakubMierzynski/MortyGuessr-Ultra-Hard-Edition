import 'package:flutter/material.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/services/check_internet_connection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void noInternetSnackbar(BuildContext context) async {
  bool isOnline = await hasInternet();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(20.r)),
      ),
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 2),
      content: Center(
        child: (isOnline)
            ? Text(
                "You're online again!",
                style: TextStyle(color: fontColor, fontSize: 20.r),
              )
            : Text(
                "You're still offline",
                style: TextStyle(color: fontColor, fontSize: 20.r),
              ),
      ),
    ),
  );
}
