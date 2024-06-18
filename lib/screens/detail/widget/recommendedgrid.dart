// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/models/movies.dart';
import 'package:netflix/screens/detail/presentation/detail.dart';
import 'package:netflix/screens/home/functions/navigation_transition.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:netflix/styles/customtext/text.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Recommendedgrid extends StatefulWidget {
  final Future<List<Movies>> recomendedlist;
  final YoutubePlayerController? youtubePlayerController;
  final Movies moviedetail;
   const Recommendedgrid({super.key,required this.recomendedlist,required this.youtubePlayerController
   ,required this.moviedetail
   });

  @override
  State<Recommendedgrid> createState() => _RecommendedgridState();
}

class _RecommendedgridState extends State<Recommendedgrid> {
  late Future<List<Movies>> recomendedlist;
  YoutubePlayerController? youtubePlayerController;
  @override
  void initState() {
    super.initState();
    recomendedlist=widget.recomendedlist;
    youtubePlayerController=widget.youtubePlayerController;
  }
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<List<Movies>>(
                  future: recomendedlist,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (context, index) {
                          return shimmerforrecommendedgrid();
                        },
                      );
                    } else if (snapshot.hasData) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async{
                                 if (youtubePlayerController != null) {
                youtubePlayerController!.pause();
              } String? id =
                      await Api().getvideourl(snapshot.data![index].id);

              Navigator.of(context)
                  .push(Custompageroute(child: Detailpage(moviedetail: snapshot.data![index], vid: id)));
                            },
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${Api.imageurl}${snapshot.data![index].posterpath}',
                              fit: BoxFit.fill,
                              placeholder: (context, url) {
                                return shimmerforrecommendedgrid();
                                // return Shimmer.fromColors(
                                //   baseColor: Colors.grey[300]!,
                                //   highlightColor: Colors.grey[100]!,
                                //   child: Container(
                                //     color: Colors.grey.shade900,
                                //   ),
                                // );
                              },
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Column(
                        children: [
                          Center(
                            child: netflixtext(
                              text: 'Failed to load recommended movies',
                              colour: red,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                recomendedlist = Api().getrecommendedmovies(
                                    id: widget.moviedetail.id);
                              });
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: netflixtext(
                          text: 'No recommended movies available',
                          colour: white,
                        ),
                      );
                    }
                  },
                );
  }

  Shimmer shimmerforrecommendedgrid() {
    return Shimmer.fromColors(
                          baseColor: shimmerforrecommendedgridbasecolor,
                          highlightColor: shimmerforrecommendedgridhighlightcolor,
                          child: Container(
                            color: shimmerblack,
                          ),
                        );
  }

  }
