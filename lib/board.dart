import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetrics_game/widgets/GreyContainerWidget.dart';
import 'package:tetrics_game/widgets/piece.dart';
import 'package:tetrics_game/widgets/pixel.dart';
import 'package:tetrics_game/score.dart';
import 'package:tetrics_game/widgets/values.dart';

num highScore = 0;

class BoardScreen extends StatefulWidget {
  final bool isFirst;

  const BoardScreen({super.key, this.isFirst = false});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  Piece currentPiece = Piece(type: Tetramino.I);
  bool isGameOver = false;
  bool isStart = false;

  num curentScore = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isStart = widget.isFirst;
      setState(() {});
    });
  }

  void moveLeft() {
    if (!checkCollision(Directions.left)) {
      setState(() {
        currentPiece.movePiece(Directions.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Directions.right)) {
      setState(() {
        currentPiece.movePiece(Directions.right);
      });
    }
  }

  int _seconds = 120;
  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => ScorePage(
                      currentScore: curentScore,
                      highScore: highScore,
                      function: () {
                        if (curentScore > highScore) {
                          highScore = curentScore;
                        }
                        startGame();
                        resetGame();
                        isStart = false;
                      },
                    )),
          );

          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  bool gameOver() {
    for (int i = 0; i < rowLength; i++) {
      if (gameBoard[0][i] != null) {
        return true;
      }
    }
    return false;
  }

  void rotate() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLines() {
    for (int row = colLength - 1; row > 0; row--) {
      bool rowisFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowisFull = false;
          break;
        }
      }

      if (rowisFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);
        curentScore = curentScore + 10;
      }
    }
  }

  void startGame() {
    currentPiece.initializePiece();
    Duration framerate = const Duration(milliseconds: 300);

    gameLoop(framerate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        clearLines();

        checklanding();
        if (isGameOver == true) {
          timer.cancel();

          Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => ScorePage(
                      currentScore: curentScore,
                      highScore: highScore,
                      function: () {
                        if (curentScore > highScore) {
                          highScore = curentScore;
                        }
                        resetGame();
                        startGame();
                        isStart = false;
                      },
                    )),
          );
        }

        currentPiece.movePiece(Directions.down);
      });
    });
  }

  void resetGame() {
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );

    isGameOver = false;
    curentScore = 0;
    _seconds = 120;

    checkNewPiece();
  }

  bool checkCollision(
    Directions direction,
  ) {
    for (int i = 0; i < currentPiece.positions.length; i++) {
      int row = (currentPiece.positions[i] / rowLength).floor();
      int col = currentPiece.positions[i] % rowLength;

      //adjust the row & col based on directions

      if (direction == Directions.left) {
        col -= 1;
      } else if (direction == Directions.right) {
        col += 1;
      } else if (direction == Directions.down) {
        row += 1;
      }

      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }
      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }
    return false;
  }

  void checklanding() {
    if (checkCollision(
      Directions.down,
    )) {
      for (int i = 0; i < currentPiece.positions.length; i++) {
        int row = (currentPiece.positions[i] / rowLength).floor();
        int col = currentPiece.positions[i] % rowLength;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      checkNewPiece();
    }
  }

  void checkNewPiece() {
    Random random = Random();

    Tetramino randomType =
        Tetramino.values[random.nextInt(Tetramino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (gameOver()) {
      isGameOver = true;
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(seconds: _seconds);
    String formattedTime = _formatDuration(duration);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.98,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GreyContainerWidget(
                      title: 'High Score:',
                      color: const Color.fromARGB(255, 30, 150, 46),
                      subTitle: highScore.toString(),
                    ),
                    GreyContainerWidget(
                        subTitle: curentScore.toString(),
                        color: Colors.black,
                        title: 'Score:'),
                    GreyContainerWidget(
                        subTitle: formattedTime,
                        color: Colors.black,
                        title: 'Timer:')
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 2, 2, 2),
                        border: Border.all(
                          width: 0.5,
                          color: const Color.fromARGB(255, 130, 47, 255),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: rowLength * colLength,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 0,
                                  crossAxisCount: rowLength),
                          itemBuilder: (context, index) {
                            int row = (index / rowLength).floor();
                            int col = index % rowLength;

                            if (currentPiece.positions.contains(index)) {
                              return Pixel(
                                  isPixel: true,
                                  child: '',
                                  pixelColor: currentPiece.color);
                            } else if (gameBoard[row][col] != null) {
                              final Tetramino? tetraType = gameBoard[row][col];
                              return Pixel(
                                  isPixel: true,
                                  child: '',
                                  pixelColor: tetraColor[tetraType]);
                            } else {
                              return Pixel(
                                  isPixel: false,
                                  child: '',
                                  pixelColor:
                                      const Color.fromARGB(255, 2, 2, 2));
                            }
                          }),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(30),
                        highlightColor: Colors.white,
                        onTap: () {
                          moveLeft();
                        },
                        child: Image.asset(
                          'assets/icons1.png',
                          height: 60,
                          //height: 70,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(30),
                        highlightColor: Colors.white,
                        onTap: () {
                          rotate();
                        },
                        child: Image.asset(
                          'assets/icons3.png',
                          height: 60,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(30),
                        highlightColor: Colors.white,
                        onTap: () {
                          moveRight();
                        },
                        child: Image.asset(
                          'assets/icons2.png',
                          height: 60,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (isStart) {
                            isStart = false;
                            print('Chitti macha');
                            _startTimer();
                            startGame();
                          } else {
                            resetGame();
                          }
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: isStart
                                ? const LinearGradient(
                                    colors: [
                                        Color.fromARGB(255, 255, 179, 0),
                                        Color.fromARGB(255, 246, 181, 4),
                                        Color.fromARGB(255, 231, 216, 180),
                                      ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)
                                : const LinearGradient(
                                    colors: [
                                        Color.fromARGB(255, 192, 24, 91),
                                        Color.fromARGB(255, 198, 22, 92),
                                        Color.fromARGB(255, 236, 113, 162),
                                      ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 3, 1, 1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(4, 4),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: Text(
                              isStart ? 'START' : 'RESTART',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: isStart ? Colors.black : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
