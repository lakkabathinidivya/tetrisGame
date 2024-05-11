import 'dart:async';
import 'dart:math';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:tetrics_game/piece.dart';
import 'package:tetrics_game/pixel.dart';
import 'package:tetrics_game/values.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  Piece currentPiece = Piece(type: Tetramino.T);
  bool isGameOver = false;
  int curentScore = 0;

  @override
  void initState() {
    super.initState();
    startGame();
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
        curentScore++;
      }
    }
  }

  bool GameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  void startGame() {
    currentPiece.initializePiece();
    Duration framerate = const Duration(milliseconds: 1000);

    gameLoop(framerate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        clearLines();
        checklanding();
        if (isGameOver == true) {
          timer.cancel();

          gameOverMessage();
        }

        currentPiece.movePiece(Directions.down);
      });
    });
  }

  void gameOverMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            backgroundColor: const Color.fromARGB(129, 34, 32, 32),
            title: Center(
                child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(73, 0, 0, 0),
                  borderRadius: BorderRadius.circular(15)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: NeonText(
                  text: 'GAME OVER',
                  textColor: Colors.deepOrange,
                  spreadColor: Colors.orange,
                  textSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Image.asset(
                    'assets/game.png',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'TOP SCORE',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  '$curentScore',
                  style: const TextStyle(
                      fontSize: 100,
                      height: 0,
                      color: Color.fromARGB(255, 206, 255, 43),
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () {
                  resetGame();
                  Navigator.pop(context);
                },
                child: NeonContainer(
                  borderRadius: BorderRadius.circular(10),
                  spreadColor: Colors.deepPurple,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: FlickerNeonText(
                      text: "RESTART",
                      textColor: Colors.white,
                      flickerTimeInMilliSeconds: 1800,
                      spreadColor: Colors.red,
                      fontWeight: FontWeight.w500,
                      blurRadius: 20,
                      textSize: 20,
                    ),
                  ),
                ),
              )
            ],
          );
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

    checkNewPiece();
    startGame();
  }

  bool checkCollision(Directions direction) {
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
    if (checkCollision(Directions.down)) {
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      //canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        resetGame();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 6, 18),
          centerTitle: true,
          title: const Text(
            'Tetrics Game',
          ),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.74,
                    width: double.infinity,
                    // padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 38, 16, 72),
                        border: Border.all(
                          width: 0.5,
                          color: const Color.fromARGB(255, 130, 47, 255),
                        )),
                    child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: rowLength * colLength,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 0, crossAxisCount: rowLength),
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
                                pixelColor: const Color.fromARGB(255, 2, 2, 2));
                          }
                        }),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
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
                          // height: 70,
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
                          //height: 70,
                        ),
                      ),
                      NeonContainer(
                        borderRadius: BorderRadius.circular(15),
                        borderWidth: 5,
                        borderColor: const Color.fromARGB(255, 222, 215, 231),
                        containerColor: const Color.fromARGB(255, 96, 0, 240),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Text(
                            'Score : $curentScore',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
