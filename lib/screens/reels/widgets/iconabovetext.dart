
import 'package:flutter/material.dart';
import 'package:netflix/styles/customtext/text.dart';

Widget iconabovetext({required IconData icon, required String text}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Column(
      children: [
        Icon(
          icon,
          size: 35,
        ),
        netflixtext(text: text, fs: 14),
      ],
    ),
  );
}
