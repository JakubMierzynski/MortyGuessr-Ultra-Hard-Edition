import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


const fontColor = Color.fromARGB(255, 0, 230, 118);
const greenAccent = Colors.greenAccent;
final boxShadow = BoxShadow(
  color: fontColor.withOpacity(0.6),
  blurRadius: 8.r,
  spreadRadius: 2.r,
);

const particleOptions = ParticleOptions(
  baseColor: fontColor,
  minOpacity: 0.1,
  maxOpacity: 0.3,
  particleCount: 20,
  spawnMinSpeed: 10,
  spawnMaxSpeed: 80,
);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
