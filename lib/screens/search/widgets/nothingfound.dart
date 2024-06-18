import 'package:flutter/material.dart';
import 'package:netflix/styles/customtext/text.dart';

Padding nothingfound() {
    return Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    netflixtext(text: "Oops. We haven't got that."),
                    netflixtext(
                        fs: 15,
                        fw: FontWeight.normal,
                        text: 'Try searching for another movies or shows')
                  ],
                ),
              );
  }
