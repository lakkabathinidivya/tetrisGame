import 'package:flutter/material.dart';
import 'dart:math' as math;

class Pixel extends StatelessWidget {
  Color? pixelColor;
  bool isPixel;

  String child;
  Pixel(
      {super.key,
      required this.pixelColor,
      required this.isPixel,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: pixelColor,
          gradient: isPixel
              ? LinearGradient(
                  begin: const Alignment(
                    -0.5,
                    1,
                  ),
                  end: const Alignment(-3, -0),
                  transform: const GradientRotation(math.pi / 5),
                  colors: [
                      pixelColor!,
                      Colors.white,
                    ])
              : null,
        ),
        child: Center(
          child: Text(
            child,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
