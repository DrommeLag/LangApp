import 'package:flutter/material.dart';

const Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A67E9), Color(0xFF0B6CE5), Color(0xFF39A5B4)],
    stops: [0, 0.1, 1]);

const Gradient searchbarGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF76EFFF), Color(0xFFFFF500)],
  stops: [0, 0.8],
);
