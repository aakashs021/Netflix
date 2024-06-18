import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix/screens/bottom_navbar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    audio();
    super.initState();
    const Splash();
    splashfunction(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Lottie.asset('assets/lotties/netflix_logo.json'),
        ),
      ),
    );
  }
}
audio()async{
  AudioPlayer p=AudioPlayer();
 await p.setAsset('assets/audios/netflixintrosound.mp3',
//  preload: false
 );
 p.play();
}
splashfunction(context) async {
  Timer(const Duration(milliseconds: 4500), () {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Bottomnavbar(),
    ));
  });
}
