 import 'package:flutter/material.dart';
import 'package:netflix/styles/colors/colors.dart';

Tab tabOfNew(
      {required String tabTitle, required int number, required int current}) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          color: number == current ? white : black,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: white, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            tabTitle,
            style: TextStyle(
              color: number == current ? black : white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }