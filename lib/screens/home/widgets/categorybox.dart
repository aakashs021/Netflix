import 'package:flutter/material.dart';
import 'package:netflix/styles/colors/colors.dart';

Widget categorybox(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      border: Border.all(color: white, width: 1),
    ),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Text(
      text,
      style:  const TextStyle(
        color: white,
        fontSize: 11,
      ),
    ),
  );
}