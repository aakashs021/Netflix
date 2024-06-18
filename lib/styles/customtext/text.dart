import 'package:flutter/material.dart';
import 'package:netflix/styles/colors/colors.dart';

Text netflixtext({required String text, Color colour = white, double fs=17,
FontWeight fw=FontWeight.w900,bool textalign=false
}) {
  return Text(
    textAlign: textalign?TextAlign.justify:null,
    text,
    style: TextStyle(
      
        color: colour,
        fontFamily: 'Netflixfont',
        fontWeight: fw,
        fontSize: fs),
  );
}
