import 'package:flutter/material.dart';
import 'package:netflix/styles/colors/colors.dart';

Widget iconWithText(IconData icon, String label,
    {Function? fun, bool issizedbox = false, double iconsize = 12}) {
  double? h = issizedbox ? 0 : 5;
  return Column(
    children: [
      IconButton(
        onPressed: () async {
          if (fun != null) {
            await fun();
          }
        },
        icon: Icon(icon, color: white),
      ),
      SizedBox(height: h),
      Text(label, style:  const TextStyle(color: white, fontSize: 12)),
    ],
  );
}
