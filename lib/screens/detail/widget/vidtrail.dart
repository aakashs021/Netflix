import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Youtubevid extends StatefulWidget {
  final String vid;

  const Youtubevid({super.key, required this.vid});

  @override
  State<Youtubevid> createState() => _YoutubevidState();
}

class _YoutubevidState extends State<Youtubevid> {
  late YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=${widget.vid}');
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: true),
      );
    } else {
      throw 'Invalid video ID';
    }
  }

  @override
  void dispose() {
    _controller!.pause();
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller != null
        ? YoutubePlayer(controller: _controller!)
        : const Center(
            child: Text('Error loading video'),
          );
  }
}
