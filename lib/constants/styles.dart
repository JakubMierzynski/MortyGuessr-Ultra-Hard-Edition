import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

final fontColor = const Color.fromARGB(255, 0, 230, 118);
const greenAccent = Colors.greenAccent;
final boxShadow = BoxShadow(
  color: fontColor.withOpacity(0.6),
  blurRadius: 8,
  spreadRadius: 2,
);

final particleOptions = ParticleOptions(
  baseColor: fontColor,
  minOpacity: 0.1,
  maxOpacity: 0.3,
  particleCount: 20,
  spawnMinSpeed: 10,
  spawnMaxSpeed: 80
);
