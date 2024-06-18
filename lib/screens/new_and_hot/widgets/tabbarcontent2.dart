import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/models/movies.dart';
import 'package:netflix/screens/detail/widget/iconwithtext.dart';
import 'package:netflix/screens/home/functions/retryfetch.dart';
import 'package:netflix/screens/new_and_hot/widgets/shimmerloadingfortab2.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

class Tabbarcontent2 extends StatefulWidget {
  const Tabbarcontent2({super.key});

  @override
  State<Tabbarcontent2> createState() => _Tabbarcontent2State();
}

class _Tabbarcontent2State extends State<Tabbarcontent2> {
  late Future<List<Movies>> popular;

  @override
  void initState() {
    super.initState();
    popular = retryFetchMovies(() => Api().gettrendingmovies());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 3600,
        width: double.infinity,
        child: FutureBuilder<List<Movies>>(
          future: popular,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return shimmerLoadingfortab2();
            } else if (snapshot.hasError) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  shimmerLoadingfortab2(),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        popular =
                            retryFetchMovies(() => Api().gettrendingmovies());
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              List<Movies> sortpopular = snapshot.data!.sublist(0, 10);
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sortpopular.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 360,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            color: red,
                            height: 175,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  '${Api.imageurl}${sortpopular[index].backdroppath}',
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor:
                                    black,
                                highlightColor: shimmerLoadingfortab1highlightcolor,
                                child: Container(
                                  color: shimmerblack, 
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              iconWithText(Icons.share, 'Share',
                                  issizedbox: true),
                              iconWithText(Icons.add, 'My List',
                                  issizedbox: true),
                              iconWithText(Icons.play_arrow, 'Play',
                                  issizedbox: true)
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            sortpopular[index].overview,
                            style: TextStyle(color: downloadpagetextcolor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  
}
