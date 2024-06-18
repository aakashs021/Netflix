// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/models/movies.dart';
import 'package:netflix/screens/detail/presentation/detail.dart';
import 'package:netflix/screens/home/functions/navigation_transition.dart';
import 'package:netflix/screens/home/functions/retryfetch.dart';
import 'package:netflix/screens/home/widgets/button_primaryimage.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePagePrimaryImage extends StatefulWidget {
  final double height;
  final double width;
  final Future<List<Movies>> list;

  const HomePagePrimaryImage({
    super.key,
    required this.height,
    required this.width,
    required this.list,
  });

  @override
  State<HomePagePrimaryImage> createState() => _HomePagePrimaryImageState();
}

class _HomePagePrimaryImageState extends State<HomePagePrimaryImage> {
  int _currentIndex = 0;
  late Timer _timer;
  late Future<List<Movies>> list;

  @override
  void initState() {
    super.initState();
    list = widget.list;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _currentIndex =
            (_currentIndex + 1) % 10; // Assuming 10 movies in the list
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(10),
          height: widget.height * 0.70,
          width: widget.width,
          child: Stack(
            children: [
              FutureBuilder<List<Movies>>(
                future: widget.list,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Shimmer.fromColors(
                        baseColor: shimmerbasecolor,
                        highlightColor: shimmerhighlightcolor,
                        child: Container(
                          height: widget.height * 0.70,
                          width: widget.width,
                          decoration: BoxDecoration(
                            color: shimmerbasecolor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error: ${snapshot.error}',
                            style:  const TextStyle(color: red),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              list =
                                  retryFetchMovies(() => Api().getdicovermovies());
                              setState(() {});
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return  const Center(
                      child: Text(
                        "No data found",
                        style: TextStyle(color: grey),
                      ),
                    );
                  } else {
                    final movie =
                        snapshot.data![_currentIndex % snapshot.data!.length];
                    return InkWell(
                      onTap: () async {
                        String? id = await Api()
                            .getvideourl(snapshot.data![_currentIndex].id);
                        Navigator.of(context).push(Custompageroute(
                            child: Detailpage(
                                moviedetail: snapshot.data![_currentIndex],
                                vid: id)));
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: '${Api.imageurl}${movie.posterpath}',
                              fit: BoxFit.fill,
                              width: widget.width,
                              height: widget.height * 0.70,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: shimmerbasecolor,
                                highlightColor: shimmerhighlightcolor,
                                child: Container(
                                  width: widget.width,
                                  height: widget.height * 0.70,
                                  color: shimmerbasecolor,
                                ),
                              ),
                              errorWidget: (context, url, error) =>  const Center(
                                child: Icon(Icons.error, color: red),
                              ),
                            ),
                          ),
                          Container(
                            width: widget.width,
                            height: widget.height * 0.70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  transparent,
                                  homepageblackwithopacity,
                                ],
                                stops: const [0.5, 1.0],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buttononimage(
                      height: widget.height,
                      textcolor: black,
                      icon: Icons.play_arrow,
                      text: 'Play',
                      colour: white,
                    ),
                    const SizedBox(width: 15),
                    buttononimage(
                      height: widget.height,
                      textcolor: white,
                      icon: Icons.add,
                      text: 'My List',
                      colour: buttononprimaryopacity,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
