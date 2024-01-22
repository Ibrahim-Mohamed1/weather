import 'package:flutter/material.dart';

Widget weatherTile(String title, dynamic value, String backgroundImage,
    [dynamic measurement, double? imageScale]) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      image: backgroundImage.isEmpty
          ? null
          : DecorationImage(
              image: AssetImage('assets/$backgroundImage'),
              scale: imageScale ?? 19.0,
              alignment: Alignment(-0.9, -0.9)),
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white.withOpacity(0.05),
      border: Border.all(
        color: Colors.white.withOpacity(0.1),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$value$measurement', style: const TextStyle(fontSize: 30)),
        Text('$title', style: const TextStyle(fontSize: 14)),
      ],
    ),
  );
}
