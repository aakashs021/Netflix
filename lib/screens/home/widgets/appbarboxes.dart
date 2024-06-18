import 'package:flutter/material.dart';
import 'package:netflix/screens/home/widgets/categorybox.dart';

SliverToBoxAdapter appbarboxes() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            categorybox('TV Shows'),
            categorybox('Movies'),
            categorybox('Categories'),
          ],
        ),
      ),
    );
  }