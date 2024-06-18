// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/models/movies.dart';
import 'package:netflix/screens/detail/presentation/detail.dart';
import 'package:netflix/screens/home/functions/navigation_transition.dart';
import 'package:netflix/screens/home/functions/retryfetch.dart';
import 'package:netflix/screens/home/widgets/netflixtop10number.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

class Gridtop10 extends StatefulWidget {
  final Future<List<Movies>> list;

  const Gridtop10({required this.list, super.key});

  @override
  State<Gridtop10> createState() => _Gridtop10State();
}

class _Gridtop10State extends State<Gridtop10> {
  late Future<List<Movies>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FutureBuilder<List<Movies>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Assuming we want 10 shimmer placeholders
                itemBuilder: (context, index) {
                  return Container(
                    width: 165,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: shimmerforgridtop10(),
                  );
                },
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
                      setState(() {
                        _moviesFuture =
                            retryFetchMovies(Api().getnowplayingmovies);
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            List<Movies> top10 = snapshot.data!.length > 10
                ? snapshot.data!.sublist(0, 10)
                : snapshot.data!;
      
            return SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: top10.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      String? id =
                          await Api().getvideourl(snapshot.data![index].id);
                      Navigator.of(context).push(Custompageroute(
                          child: Detailpage(
                              moviedetail: snapshot.data![index], vid: id)));
                    },
                    child: Container(
                      width: index == 9 ? 205 : 160,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: NetflixTop10Number(
                              number: index + 1,
                              borderColor: white,
                              textColor: black,
                              borderWidth: 4,
                              fontSize: 80,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${Api.imageurl}${top10[index].posterpath}',
                                width: 120,
                                height: 160,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => shimmerforgridtop10(),
                                // Shimmer.fromColors(
                                //   baseColor: shimmerbasecolor,
                                //   highlightColor: shimmerhighlightcolor,
                                //   child: Container(
                                //     width: 120,
                                //     height: 160,
                                //     color: shimmerbasecolor,
                                //   ),
                                // ),
                                errorWidget: (context, url, error) =>  const Icon(
                                  Icons.error,
                                  color: red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Shimmer shimmerforgridtop10() {
    return Shimmer.fromColors(
                    baseColor: shimmerbasecolor,
                    highlightColor: shimmerhighlightcolor,
                    child: Container(
                      color: shimmerbasecolor,
                    ),
                  );
  }
}
