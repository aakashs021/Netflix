import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/models/movies.dart';
import 'package:netflix/screens/detail/widget/elevatedbuttondetailpage.dart';
import 'package:netflix/screens/detail/widget/iconwithtext.dart';
import 'package:netflix/screens/detail/widget/ratingandotherdetail.dart';
import 'package:netflix/screens/detail/widget/recommendedgrid.dart';
import 'package:netflix/screens/detail/widget/vidorimg.dart';
import 'package:netflix/screens/home/functions/navigation_transition.dart';
import 'package:netflix/screens/search/presentation/search.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:netflix/styles/customtext/text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Detailpage extends StatefulWidget {
  final Movies moviedetail;
  final String? vid;

  const Detailpage({super.key, required this.moviedetail, required this.vid});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> with WidgetsBindingObserver {
  late Future<List<Movies>> recomendedlist;
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    recomendedlist = Api().getrecommendedmovies(id: widget.moviedetail.id);

    if (widget.vid != null) {
      final videoId = YoutubePlayer.convertUrlToId(
          'https://www.youtube.com/watch?v=${widget.vid}');
      if (videoId != null) {
        _youtubePlayerController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: true),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (_youtubePlayerController != null) {
                  _youtubePlayerController!.pause();
                }
                Navigator.of(context)
                    .push(Custompageroute(child: const Searchpage()));
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            vidorimg(width,
                vid: widget.vid,
                youtubePlayerController: _youtubePlayerController,
                moviedetail: widget.moviedetail),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  netflixtext(
                    text: widget.moviedetail.title,
                    fs: 25,
                    fw: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  ratingandotherdetails(
                      orglan: widget.moviedetail.originallanguage.toUpperCase(),
                      voteaverage: widget.moviedetail.voteaverage.toString(),
                      date: widget.moviedetail.releasedate.substring(0, 4)),
                  const SizedBox(height: 10),
                  elevatedbuttonondetailpage(
                    text: 'Play',
                    icon: Icons.play_arrow,
                    backgroundColor: white,
                    foregroundColor: black,
                  ),
                  const SizedBox(height: 10),
                  elevatedbuttonondetailpage(
                    text: 'Download',
                    icon: Icons.download,
                    backgroundColor: shimmerbasecolor,
                    foregroundColor: white,
                  ),
                  const SizedBox(height: 10),
                  netflixtext(
                    text: widget.moviedetail.overview,
                    fs: 12,
                    fw: FontWeight.w100,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      iconWithText(Icons.add, 'My List'),
                      iconWithText(Icons.thumb_up_alt_outlined, 'Rate'),
                      iconWithText(Icons.share, 'Share'),
                      iconWithText(Icons.download, 'Download'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  netflixtext(
                      text: 'Recommended Movies', fs: 20, fw: FontWeight.bold),
                  const SizedBox(height: 10),
                  Recommendedgrid(
                      recomendedlist: recomendedlist,
                      youtubePlayerController: _youtubePlayerController,
                      moviedetail: widget.moviedetail),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
