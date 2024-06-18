 import 'package:flutter/material.dart';
import 'package:netflix/screens/home/functions/navigation_transition.dart';
import 'package:netflix/screens/search/presentation/search.dart';
import 'package:netflix/styles/colors/colors.dart';

SliverAppBar homeappbar(BuildContext context,bool isScrolled) {
    return SliverAppBar(
          backgroundColor: isScrolled
              ?homepageblackwithopacity
              : transparent,
          pinned: true,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double appBarHeight = constraints.biggest.height;
              final double statusBarHeight =
                  MediaQuery.of(context).padding.top;
              final double visibleMainHeight = appBarHeight - statusBarHeight;
              final double t =
                  (visibleMainHeight - kToolbarHeight) / (kToolbarHeight);
              final Color backgroundColor = Color.lerp(
                Colors.transparent,
                Colors.black.withOpacity(0.7),
                t,
              )!;
              return Container(
                color: backgroundColor,
              );
            },
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/netflix.png",
              width: 40,
              height: 55,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(Custompageroute(child: const Searchpage()));
              },
              icon: const Icon(
                Icons.search,
                size: 35,
              ),
            ),
          ],
        );
  }

