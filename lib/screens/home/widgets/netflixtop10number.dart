import 'package:flutter/material.dart';
import 'package:netflix/styles/colors/colors.dart';

class NetflixTop10Number extends StatelessWidget {
  final int number;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;
  final double fontSize;

 const NetflixTop10Number({super.key, 
  
    required this.number,
    required this.borderColor,
    required this.textColor,
    required this.borderWidth,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          number.toString(),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = borderWidth
              ..color = borderColor,
          ),
        ),
        Text(
          number.toString(),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
            shadows: [
              Shadow(
                offset: const Offset(4.0, 4.0),
                blurRadius: 4.0,
                color: netflixtop10numberblackopacity,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
