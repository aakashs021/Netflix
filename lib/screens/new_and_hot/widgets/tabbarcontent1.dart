// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/models/movies.dart';
import 'package:netflix/screens/detail/presentation/detail.dart';
import 'package:netflix/screens/detail/widget/iconwithtext.dart';
import 'package:netflix/screens/home/functions/navigation_transition.dart';
import 'package:netflix/screens/home/functions/retryfetch.dart';
import 'package:netflix/screens/new_and_hot/widgets/shimmerloadingfortab1.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

class Tabbarcontent1 extends StatefulWidget {
  const Tabbarcontent1({super.key});

  @override
  State<Tabbarcontent1> createState() => _AccountState();
}

class _AccountState extends State<Tabbarcontent1> {
  late Future<List<Movies>> upcoming;

  @override
  void initState() {
    super.initState();
    upcoming = retryFetchMovies(() => Api().getupcomingmovies());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 3600,
      child: FutureBuilder<List<Movies>>(
        future: upcoming,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return shimmerLoadingfortab1();
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                shimmerLoadingfortab1(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      upcoming =
                          retryFetchMovies(() => Api().getupcomingmovies());
                    });
                  },
                  child: const Text('Retry'),
                ),
              ],
            );
          } else {
            List<Movies> sortedupcoming = snapshot.data!.sublist(0, 10);
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sortedupcoming.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 360,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Jun',
                              style: TextStyle(
                                  color: downloadpagetextcolor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              sortedupcoming[index].releasedate.substring(8),
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w900),
                            ),
                          ],
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
                                child: vidorimg(sortedupcoming[index]),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 75,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    iconWithText(Icons.alarm, 'reminder',
                                        issizedbox: true),
                                    iconWithText(Icons.info, 'info',
                                        fun: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible:
                                            false,
                                        builder: (context) => const Center(
                                            child: CircularProgressIndicator(
                                          color: Colors.white,
                                        )),
                                      );

                                      String? id = await Api().getvideourl(
                                          snapshot.data![index].id);
                                      Navigator.pop(
                                          context); 
                                      Navigator.of(context)
                                          .push(Custompageroute(
                                        child: Detailpage(
                                          vid: id,
                                          moviedetail: snapshot.data![index],
                                        ),
                                      ));
                                    }),
                                  ],
                                ),
                              ),
                              Text(
                                  style: TextStyle(color: downloadpagetextcolor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  sortedupcoming[index].overview)
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

  ClipRRect vidorimg(
    Movies sortedupcoming,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: '${Api.imageurl}${sortedupcoming.backdroppath}',
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: shimmerblack, 
          highlightColor:
              shimmerLoadingfortab1highlightcolor,
          child: Container(
            color:
                shimmerblack,
          ),
        ),
      ),
    );
  }
}


