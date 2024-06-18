import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:netflix/styles/customtext/text.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: downloadAppBar(),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: TextButton.icon(
              onPressed: () {},
              label: netflixtext(text: 'System Settings'),
              icon:  const Icon(
                Icons.settings,
                color: white,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: netflixtext(
                  text: 'Introducing Downloads for You',
                  fs: 25,
                ),
              ),
              netflixtext(
                fs: 16,
                colour: downloadpagetextcolor,
                text: "We'll download a personalised selection of",
              ),
              netflixtext(
                fs: 16,
                colour: downloadpagetextcolor,
                text: "movies and shows for you, so there's",
              ),
              netflixtext(
                fs: 16,
                colour: downloadpagetextcolor,
                text: ' always something to watch on your',
              ),
              netflixtext(
                fs: 16,
                colour: downloadpagetextcolor,
                text: 'device.',
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          transformWidget(),
        ],
      ),
    );
  }

  AppBar downloadAppBar() {
    return AppBar(
      title: netflixtext(text: 'Downloads'),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.cast)),
        const SizedBox(width: 10),
        Image.asset(
          'assets/images/netflix_account_img.jpg',
          fit: BoxFit.cover,
          width: 25,
          height: 25,
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Stack transformWidget() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: CircleAvatar(
            backgroundColor: downloadpagecircleavatarcolor,
            radius: 140,
          ),
        ),
        Positioned(
          left: 40,
          bottom: 25,
          child: Transform.rotate(
            angle: -20 * pi / 180,
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 150,
              height: 200,
              child: CachedNetworkImage(
                imageUrl:
                    'https://images.wallpapersden.com/image/download/4k-borderlands-movie-poster_bmdsbm2UmZqaraWkpJRmbmdlrWZlbWU.jpg',
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: black,
                  highlightColor: grey,
                  child: Container(
                    color: black,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Positioned(
          right: 40,
          bottom: 25,
          child: Transform.rotate(
            angle: 20 * pi / 180,
            child: Container(
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 150,
              height: 200,
              child: CachedNetworkImage(
                imageUrl:
                    'https://www.impawards.com/2024/posters/fall_guy_ver2_xlg.jpg',
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: black,
                  highlightColor: grey,
                  child: Container(
                    color: black,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          child: Container(
            decoration: BoxDecoration(
              color: red,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 150,
            height: 225,
            child: CachedNetworkImage(
              imageUrl:
                  'https://www.washingtonpost.com/graphics/2019/entertainment/oscar-nominees-movie-poster-design/img/black-panther-web.jpg',
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: black,
                highlightColor: grey,
                child: Container(
                  color: black,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }
}
