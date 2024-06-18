import 'dart:async';
import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/models/movies.dart';
import 'package:netflix/screens/home/functions/retryfetch.dart';
import 'package:netflix/screens/home/widgets/appbarboxes.dart';
import 'package:netflix/screens/home/widgets/gridtop10.dart';
import 'package:netflix/screens/home/widgets/homeappbar.dart';
import 'package:netflix/screens/home/widgets/homepagesubtittle.dart';
import 'package:netflix/screens/home/widgets/popular_rated.dart';
import 'package:netflix/screens/home/widgets/primaryimage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController _scrollController;
  bool _isScrolled = false;
  late Future<List<Movies>> trendinglist;
  late Future<List<Movies>> topratedlist;
  late Future<List<Movies>> discoverlist;
  late Future<List<Movies>> nowplayinglist;

  @override
  void initState() {
    super.initState();
    trendinglist = retryFetchMovies(Api().gettrendingmovies);
    topratedlist = retryFetchMovies(Api().gettopratedmovies);
    discoverlist = retryFetchMovies(Api().getdicovermovies);
    nowplayinglist = retryFetchMovies(() => Api().getnowplayingmovies());
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          homeappbar(context,_isScrolled),
          appbarboxes(),
          HomePagePrimaryImage(
            list: discoverlist,
            height: height,
            width: width,
          ),
          homepagesubtitile(text: 'Popular Movies'),
          PopularRated(mainlist: trendinglist, height: 300, width: 160),
          homepagesubtitile(text: 'Top Rated Movies'),
          PopularRated(mainlist: topratedlist, height: 170, width: 120),
          homepagesubtitile(text: 'Top 10 Movies in India Today'),
          Gridtop10(list: nowplayinglist),
        ],
      ),
    );
  }
}

 