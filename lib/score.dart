import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:neon_widgets/neon_widgets.dart';

// ignore: must_be_immutable
class ScorePage extends StatefulWidget {
  num currentScore;
  num highScore;
  VoidCallback function;

  ScorePage({
    super.key,
    required this.currentScore,
    required this.function,
    required this.highScore,
  });

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));

    if (widget.currentScore >= widget.highScore) {
      _controllerTopCenter.play();
    }

    super.initState();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromARGB(255, 92, 0, 251),
              Color.fromARGB(255, 198, 165, 255),
              Color.fromARGB(255, 92, 0, 251),
              Color.fromARGB(255, 54, 37, 81)
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerTopCenter,
                emissionFrequency: 0.04,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    true, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Color.fromARGB(255, 235, 255, 58)
                ], // manually specify the colors to be used
                createParticlePath: drawStar, // define a custom shape/path.
              ),
            ),
            Text(
              widget.currentScore > widget.highScore
                  ? 'EXCELLENT'
                  : 'GAME OVER!',
              style: const TextStyle(
                shadows: [
                  Shadow(
                    color: Color.fromARGB(255, 23, 18,
                        18), // Choose the color of the first shadow
                    blurRadius:
                        5.0, // Adjust the blur radius for the first shadow effect
                    offset: Offset(4.0,
                        4.0), // Set the horizontal and vertical offset for the first shadow
                  ),
                ],
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ).animate(autoPlay: true).flip(
                duration: const Duration(milliseconds: 2000),
                direction: Axis.horizontal),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: DropShadow(
                blurRadius: 10,
                color: Colors.black,
                //spread: 10,
                child: Image.asset(
                  'assets/game.png',
                  height: 170,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.currentScore >= widget.highScore
                ? Container()
                : Column(
                    children: [
                      const Text(
                        'TOP SCORE :',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      NeonText(
                        text: widget.highScore.toString(),
                        textColor: const Color.fromARGB(255, 206, 255, 43),
                        spreadColor: const Color.fromARGB(255, 35, 31, 39),
                        textSize: 60,
                        blurRadius: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ],
                  ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'SCORE ',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            NeonText(
              text: widget.currentScore.toString(),
              textColor: const Color.fromARGB(255, 206, 255, 43),
              spreadColor: const Color.fromARGB(255, 70, 73, 48),
              textSize: 90,
              blurRadius: 40,
              fontWeight: FontWeight.w900,
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute<void>(
                //         builder: (BuildContext context) => const BoardScreen()),
                //     (route) => false);
             
       
                widget.function();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 192, 24, 91),
                    Color.fromARGB(255, 198, 22, 92),
                    Color.fromARGB(255, 236, 113, 162),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 23, 6, 6),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(5, 5),
                    )
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    'RESTART',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 27, 24,
                                24), // Choose the color of the first shadow
                            blurRadius:
                                5.0, // Adjust the blur radius for the first shadow effect
                            offset: Offset(3.0,
                                3.0), // Set the horizontal and vertical offset for the first shadow
                          ),
                        ],
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
