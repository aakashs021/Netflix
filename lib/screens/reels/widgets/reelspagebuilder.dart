import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/screens/reels/widgets/iconabovetext.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Reelspage extends StatefulWidget {
  final int index;
  final VoidCallback onVideoEnded;

  const Reelspage({super.key, required this.index, required this.onVideoEnded});

  @override
  State<Reelspage> createState() => _ReelspageState();
}

class _ReelspageState extends State<Reelspage> {
  late YoutubePlayerController yp;
  List<String> profileimgpath = [
    'assets/images/profile1.jpg',
    'assets/images/profile2.jpg',
    'assets/images/profile3.jpg',
    'assets/images/profile4.jpg',
    'assets/images/profile5.jpg',
    'assets/images/profile6.jpg',
    'assets/images/profile7.jpg',
    'assets/images/profile8.jpg',
    'assets/images/profile9.jpg',
    'assets/images/profile10.jpg'
  ];

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=${Api.videoList[widget.index]}');
    if (videoId != null) {
      yp = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          showLiveFullscreenButton: false,
          hideControls: true,
          hideThumbnail: true,
          autoPlay: true,
        ),
      )..addListener(() {
          if (yp.value.playerState == PlayerState.ended) {
            widget.onVideoEnded();
          }
        });
    }
  }

  @override
  void dispose() {
    yp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          // color: Colors.accents[widget.index % Colors.accents.length],
          width: double.infinity,
          height: double.infinity,
          child: YoutubePlayer(controller: yp),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black.withOpacity(0.3),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.volume_down_outlined,
                    size: 35,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        profileimgpath[widget.index],
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  iconabovetext(
                    icon: Icons.emoji_emotions_outlined,
                    text: 'Lol',
                  ),
                  iconabovetext(
                    icon: Icons.add,
                    text: 'My list',
                  ),
                  iconabovetext(
                    icon: Icons.share,
                    text: 'Share',
                  ),
                  iconabovetext(
                    icon: Icons.play_arrow,
                    text: 'Play',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
