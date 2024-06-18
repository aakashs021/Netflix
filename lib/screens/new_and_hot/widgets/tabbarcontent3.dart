import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/models/movies.dart';
import 'package:netflix/screens/detail/widget/iconwithtext.dart';
import 'package:netflix/screens/home/functions/retryfetch.dart';
import 'package:netflix/screens/new_and_hot/widgets/shimmerloadingfortab3.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

class Tabbarcontent3 extends StatefulWidget {
  const Tabbarcontent3({super.key});

  @override
  State<Tabbarcontent3> createState() => _Tabbarcontent3State();
}

class _Tabbarcontent3State extends State<Tabbarcontent3> {
  late Future<List<Movies>> top10;

  @override
  void initState() {
    super.initState();
    top10 = retryFetchMovies(() => Api().gettopratedmovies());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 3600,
      child: FutureBuilder<List<Movies>>(
        future: top10,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return shimmerLoadingfortab3();
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                shimmerLoadingfortab3(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      top10 =
                          retryFetchMovies(() => Api().gettopratedmovies());
                    });
                  },
                  child: const Text('Retry'),
                ),
              ],
            );
          } else {
            List<Movies> sortedtop10 = snapshot.data!.sublist(0, 10);
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sortedtop10.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 360,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 60,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height:
                                    175,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        '${Api.imageurl}${sortedtop10[index].backdroppath}',
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: shimmerblack,
                                      highlightColor: shimmerLoadingfortab1highlightcolor,
                                      child: Container(
                                        color: shimmerblack, 
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  iconWithText(Icons.share, 'Share',
                                      issizedbox: true),
                                  iconWithText(Icons.add, 'My List',
                                      issizedbox: true),
                                  iconWithText(Icons.play_arrow, 'Play',
                                      issizedbox: true)
                                ],
                              ),
                              Text(
                                  style: TextStyle(color: downloadpagetextcolor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  sortedtop10[index].overview)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

