// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/models/movies.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix/screens/detail/presentation/detail.dart';
import 'package:netflix/screens/home/functions/navigation_transition.dart';
import 'package:netflix/screens/search/widgets/nothingfound.dart';
import 'package:netflix/screens/search/widgets/searchrecommendedmovies.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:netflix/styles/customtext/text.dart';
import 'package:shimmer/shimmer.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  late Future<List<Movies>> recommended;
  List<Movies> searchlist = [];
  TextEditingController controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isNotEmpty) {
        try {
          List<Movies> results = await Api().fetchbysearch(name: query);
          setState(() {
            searchlist = results;
          });
        } catch (e) {
          setState(() {
            searchlist = [];
          });
        }
      } else {
        setState(() {
          searchlist = [];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    recommended = Api().gettrendingmovies();
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) return const SizedBox.shrink();
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: black,
        shadowColor: black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                color: shimmerblack,
                child: TextField(
                  controller: controller,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    fillColor: red,
                    prefixIconColor: shimmersearchpagetextfeildiconscolor,
                    suffixIconColor: shimmersearchpagetextfeildiconscolor,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      onPressed: () {
                        controller.clear();
                        setState(() {
                          searchlist = [];
                        });
                      },
                    ),
                    hintText: 'Search movies',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: controller.text.isEmpty
          ? RecommendedMovies(fetchRecommendedMovies: recommended)
          : searchlist.isEmpty && controller.text.isNotEmpty
              ? nothingfound()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: netflixtext(text: 'Movies & TV'),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: searchlist.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.75,
                            crossAxisCount: 3,
                          ),
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

                                String? id = await Api()
                                    .getvideourl(searchlist[index].id);
                                Navigator.pop(
                                    context);
                                Navigator.of(context).push(Custompageroute(
                                  child: Detailpage(
                                    vid: id,
                                    moviedetail: searchlist[index],
                                  ),
                                ));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${Api.imageurl}${searchlist[index].posterpath}',
                                  height: 400,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: shimmerforrecommendedgridbasecolor,
                                    highlightColor: shimmerforrecommendedgridhighlightcolor,
                                    child: Container(
                                      color: shimmerblack,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.grey.shade200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                           const Icon(
                                            Icons.camera_alt_outlined,
                                            color: black,
                                          ),
                                          netflixtext(
                                              text: searchlist[index].title,
                                              colour: black)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
 

  