import 'package:flutter/material.dart';

Widget elevatedbuttonondetailpage({
  required String text,
  required IconData icon,
  required Color backgroundColor,
  required Color foregroundColor,
}) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: backgroundColor,
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    ),
  );
}
