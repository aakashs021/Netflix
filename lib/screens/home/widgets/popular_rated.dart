// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/models/movies.dart';
import 'package:netflix/screens/detail/presentation/detail.dart';
import 'package:netflix/screens/home/functions/navigation_transition.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

class PopularRated extends StatefulWidget {
  final Future<List<Movies>> mainlist;
  final double height;
  final double width;
  final String cat;
  const PopularRated(
      {super.key,
      required this.mainlist,
      required this.height,
      required this.width,
      this.cat = 't'});

  @override
  State<PopularRated> createState() => _PopularRatedState();
}

class _PopularRatedState extends State<PopularRated> {
  late Future<List<Movies>> list;
  late double height;
  late double width;
  late String cat;
  @override
  void initState() {
    super.initState();
    cat = widget.cat;
    list = widget.mainlist;
    height = widget.height;
    width = widget.width;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: FutureBuilder<List<Movies>>(
          future: list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: height,
        
                ///300
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10, // Placeholder count
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.black45,
                      highlightColor: Colors.black45,
                      child: Container(
                        width: width,
        
                        ///160
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (cat == 't') {
                            list = Api().gettrendingmovies(); // Retry fetching data
                          } else if (cat == 'r') {
                            list = Api().gettopratedmovies();
                          }
                        });
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child:
                    Text('No data available', style: TextStyle(color: Colors.grey)),
              );
            } else {
              return SizedBox(
                height: height,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false,
                          builder: (context) =>  const Center(
                              child: CircularProgressIndicator(
                            color: white,
                          )),
                        );
        
                        String? id =
                            await Api().getvideourl(snapshot.data![index].id);
                        Navigator.pop(context); 
                          Navigator.of(context).push(Custompageroute(
                            child: Detailpage(
                              vid: id,
                              moviedetail: snapshot.data![index],
                            ),
                          ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        width: width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:
                                '${Api.imageurl}${snapshot.data![index].posterpath}',
                            placeholder: (context, url) => shimmerforplaceholder(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  
}
Shimmer shimmerforplaceholder() {
    return Shimmer.fromColors(
                            baseColor: shimmerbasecolor,
                            highlightColor: shimmerhighlightcolor,
                            child: Container(
                              width: 160,
                              color: grey,
                            ),
                          );
  }