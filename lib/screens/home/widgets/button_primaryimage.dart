
import 'package:flutter/material.dart';

Widget buttononimage({
  required IconData icon,
  required double height,
  required String text,
  required Color colour,
  Function? buttonworking,
  required Color textcolor,
}) {
  return Expanded(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromHeight(height * 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: colour,
      ),
      onPressed: () {
        if (buttonworking != null) {
          buttonworking();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: textcolor,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(color: textcolor),
          ),
        ],
      ),
    ),
  );
}