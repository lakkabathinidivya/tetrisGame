import 'package:flutter/material.dart';

int rowLength = 10;
int colLength = 20;

enum Tetramino { L, J, I, O, S, Z, T }

enum Directions { left, right, down }

const Map<Tetramino, Color> tetraColor = {
  Tetramino.L: Color.fromARGB(255, 255, 251, 5),
  Tetramino.I: Color.fromARGB(255, 28, 62, 255),
  Tetramino.J: Color.fromARGB(255, 205, 39, 255),
  Tetramino.O: Colors.pink,
  Tetramino.S: Colors.orange,
  Tetramino.T: Color.fromARGB(255, 33, 189, 38),
  Tetramino.Z: Color.fromARGB(255, 13, 191, 214)
};

List<List<Tetramino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);
