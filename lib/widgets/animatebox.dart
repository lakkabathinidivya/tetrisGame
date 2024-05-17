


import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimateBox extends StatelessWidget {
  final String imageString;
  final int duration;
  final int delay;
  final Color color;
final double height;

  const AnimateBox(
      {super.key,
      required this.imageString,
      required this.delay,
      required this.color,
      required this.height,
      required this.duration});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        SlideEffect(
            begin: const Offset(0, -5),
            duration: Duration(
              milliseconds: duration,
            ),
            delay: Duration(milliseconds: delay))
      ],
      child: Image.asset(
        imageString,
        color: color,
        height: height,
      ),
    );
  }
}





        //  height: 120,
        //                 color: const Color.fromARGB(255, 234, 50, 117),


        //                    color: const Color.fromRGBO(68, 227, 248, 1),
        //             height: 210,