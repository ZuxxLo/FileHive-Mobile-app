import 'package:flutter/material.dart';

class PlusValueDisplay extends StatelessWidget {
  final int plusValue;

  const PlusValueDisplay({required this.plusValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        plusValue == 0 ? "" : "+$plusValue",
        style: const TextStyle(
            fontSize: 21,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                  // bottomLeft
                  offset: Offset(-1, -1),
                  blurRadius: 0.2,
                  color: Colors.black),
              Shadow(
                  // bottomRight
                  blurRadius: 0.2,
                  offset: Offset(1, -1),
                  color: Colors.black),
              Shadow(
                  // topRight
                  blurRadius: 0.2,
                  offset: Offset(1, 1),
                  color: Colors.black),
              Shadow(
                  // topLeft
                  blurRadius: 0.2,
                  offset: Offset(-1, 1),
                  color: Colors.black),
            ]),
      ),
    );
  }
}
