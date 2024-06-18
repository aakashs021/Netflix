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

class RecommendedMovies extends StatefulWidget {
  final Future<List<Movies>>  fetchRecommendedMovies;

  const RecommendedMovies({super.key, required this.fetchRecommendedMovies});

  @override
  State<RecommendedMovies> createState() => _RecommendedMoviesState();
}

class _RecommendedMoviesState extends State<RecommendedMovies> {
  late Future<List<Movies>> _recommendedMoviesFuture;

  @override
  void initState() {
    super.initState();
    _recommendedMoviesFuture = widget.fetchRecommendedMovies;
  }

  void _retryFetchMovies() {
    setState(() {
      _recommendedMoviesFuture = widget.fetchRecommendedMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: netflixtext(text: 'Recommended TV Shows & Movies'),
        ),
        FutureBuilder<List<Movies>>(
          future: _recommendedMoviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    const Text('Failed to load recommended movies.'),
                    ElevatedButton(
                      onPressed: _retryFetchMovies,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No recommended movies available.'));
            }

            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>  const Center(
                          child: CircularProgressIndicator(
                            color: white,
                          ),
                        ),
                      );

                      try {
                        String? id = await Api().getvideourl(snapshot.data![index].id);
                        Navigator.pop(context); 
                        Navigator.of(context).push(
                          Custompageroute(
                            child: Detailpage(
                              vid: id,
                              moviedetail: snapshot.data![index],
                            ),
                          ),
                        );
                      } catch (e) {
                        Navigator.pop(context); 
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to load video.')),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          height: 80,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: '${Api.imageurl}${snapshot.data![index].backdroppath}',
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: shimmerbasecolor,
                                highlightColor: shimmerbasecolor,
                                child: Container(
                                  width: 170,
                                  color: grey,
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: netflixtext(
                              fs: 12,
                              fw: FontWeight.w100,
                              text: snapshot.data![index].title,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.play_circle_outline_outlined),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
