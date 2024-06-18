import 'package:flutter/material.dart';
import 'package:netflix/styles/customtext/text.dart';

SliverToBoxAdapter homepagesubtitile({required String text}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: netflixtext(text: text),
      ),
    );
  }