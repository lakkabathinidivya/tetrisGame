import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tetrics_game/board.dart';
import 'package:tetrics_game/widgets/animatebox.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isAnimate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromARGB(255, 82, 11, 205),
              Color.fromARGB(255, 152, 100, 242),
              Color.fromARGB(255, 92, 0, 251),
              Color.fromARGB(255, 84, 20, 186)
            ])),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Row(
                children: [
                  RotatedBox(
                    quarterTurns: 1,
                    child: AnimateBox(
                      imageString: 'assets/t_shape.png',
                      delay: 2000,
                      height: 120,
                      color: Color.fromARGB(255, 234, 50, 117),
                      duration: 800,
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimateBox(
                  imageString: 'assets/z_shape.png',
                  delay: 1500,
                  duration: 800,
                  color: Colors.amber,
                  height: 140,
                ),
              ],
            ),
            const Text(
              'TETRA\nTRUMBLE',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Color.fromARGB(255, 40, 6, 69),
                      offset: Offset(5, 5),
                    ),
                  ],
                  fontWeight: FontWeight.w800),
            ).animate(onComplete: (controller) {
              Future.delayed(
                const Duration(milliseconds: 1000),
                () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const BoardScreen(
                                isFirst: true,
                              )),
                      (route) => false);
                },
              );
            }).scale(
                duration: const Duration(milliseconds: 1200),
                delay: const Duration(milliseconds: 3500)),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimateBox(
                    imageString: 'assets/box_shape.png',
                    delay: 500,
                    color: Color.fromRGBO(68, 227, 248, 1),
                    height: 210,
                    duration: 1000)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
