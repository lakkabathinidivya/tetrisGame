import 'package:flutter/material.dart';
import 'package:tetrics_game/board.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: TextButton(
      onPressed: () async {
      await  Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const BoardScreen();
        }));
      },
      child: const Text('hit me', style: TextStyle(fontSize: 30,),),
    )));
  }
}
