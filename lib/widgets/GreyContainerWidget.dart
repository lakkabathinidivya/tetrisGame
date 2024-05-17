import 'package:flutter/material.dart';

class GreyContainerWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color color;

  const GreyContainerWidget(
      {super.key,
      required this.subTitle,
      required this.color,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 100,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 91, 188, 46),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 211, 218, 210),
                Color.fromARGB(255, 244, 245, 244),
                Color.fromARGB(255, 186, 184, 184),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 16, 5, 5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(4, 4),
                )
              ],
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 18, 15, 15),
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  subTitle,
                  style: TextStyle(shadows: const [
                    
                  ], fontSize: 18, color: color, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          )),
    );
  }
}
