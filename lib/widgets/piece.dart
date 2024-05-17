import 'package:flutter/material.dart';
import 'package:tetrics_game/widgets/values.dart';

class Piece {
  Tetramino type;

  Piece({required this.type});

  List<int> positions = [];

  //color of tetraPiece

  Color get color {
    return tetraColor[type] ?? Colors.grey;
  }

  void initializePiece() {
    switch (type) {
      case Tetramino.L:
        positions = [-26, -16, -6, -5];
        break;

      case Tetramino.J:
        positions = [-25, -15, -5, -6];
        break;

      case Tetramino.O:
        positions = [-4, -5, -14, -15];
        break;

      case Tetramino.I:
        positions = [-4, -5, -6, -7];
        break;

      case Tetramino.S:
        positions = [-14, -15, -5, -6];

      case Tetramino.Z:
        positions = [-4, -5, -15, -16];

      case Tetramino.T:
        positions = [-5, -14, -15, -16];
        break;
      default:
    }
  }

  int rotateState = 1;

  void rotatePiece() {
    List<int> newPositions = [];

    switch (type) {
      case Tetramino.L:
        switch (rotateState) {
          case 0:
            newPositions = [
              positions[1] - rowLength,
              positions[1],
              positions[1] + rowLength,
              positions[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }

            break;

          case 1:
            newPositions = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            newPositions = [
              positions[1] + rowLength,
              positions[1],
              positions[1] - rowLength,
              positions[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            newPositions = [
              positions[1]  + 1,
              positions[1],
              positions[1] - 1,
              positions[1] - rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }

      case Tetramino.J:
        switch (rotateState) {
          case 0:
            newPositions = [
               positions[1] - rowLength,
               positions[1],
               positions[1] + rowLength,
               positions[1] + rowLength - 1 ,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }

            break;

          case 1:
            newPositions = [
               positions[1] + 1,
               positions[1],
               positions[1] - 1,
               positions[1] - rowLength - 1 ,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            newPositions = [
              positions[1] + rowLength,
              positions[1],
              positions[1] - rowLength,
              positions[1] - rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            newPositions = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }

      case Tetramino.O:
        break;

      case Tetramino.I:
        switch (rotateState) {
          

          case 0:
            newPositions = [
               positions[1]  - 1,
             
               positions[1],
               positions[1] + 1,
               positions[1] + 2,
              
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 2;
            }
            break;

        case 1:
            newPositions = [
              positions[1] - rowLength,
              positions[1],
              positions[1] + rowLength,
              positions[1] + colLength  ,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 2;
            }

            break;
        }

      case Tetramino.S:
        switch (rotateState) {
          case 0:
            newPositions = [
              positions[1] + 1,
              positions[1],
              positions[1] - rowLength ,
              positions[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 2;
            }

            break;

          case 1:
            newPositions = [
              positions[1] + rowLength,
              positions[1],
             positions[1] + 1,
             positions[1] + rowLength -  1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 2;
            }
            break;

         
            
        }

      case Tetramino.T:
        switch (rotateState) {
          

           case 0:
            newPositions = [
              positions[1] + 1,
              positions[1],
          positions[1] - 1,
              positions[1] - rowLength ,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;
             case 1:
            newPositions = [
              positions[1] - rowLength,
              positions[1],
              positions[1] + rowLength,
              positions[1]+ 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;

         


case 2:
            newPositions = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLength ,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }

            break;



            case 3:
            newPositions = [
              positions[1] + rowLength ,
              positions[1],
              positions[1] - rowLength,
              positions[1] - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 4;
            }
            break;
       

          
        }







      case Tetramino.Z:
        switch (rotateState) {
          case 0:
            newPositions = [
              positions[1] + 1,
              positions[1],
               positions[1] + rowLength + 1,
               positions[1] + rowLength + 2,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 2;
            }

            break;

          case 1:
            newPositions = [
              positions[1] + rowLength,
              positions[1],
              positions[1] + 1,
              positions[1] - rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;
              rotateState = (rotateState + 1) % 2;
            }
            break;

         
        }

        break;

      default:
    }
  }

  void movePiece(Directions directions) {
    switch (directions) {
      case Directions.down:
        for (int i = 0; i < positions.length; i++) {
          positions[i] += rowLength;
        }
        break;

      case Directions.left:
        for (int i = 0; i < positions.length; i++) {
          positions[i] -= 1;
        }
        break;

      case Directions.right:
        for (int i = 0; i < positions.length; i++) {
          positions[i] += 1;
        }
        break;

      default:
    }
  }

  bool positionValid(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    //if the position is taken return false

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!positionValid(pos)) {
        return false;
      }

      int col = pos % rowLength;

      if (col == 0) {
        firstColOccupied = true;
      }

      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }

    return !(firstColOccupied && lastColOccupied);
  }
}
