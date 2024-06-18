import 'package:flutter/material.dart';
import 'package:netflix/screens/reels/widgets/reelspagebuilder.dart';

class Reels extends StatefulWidget {
  const Reels({super.key});

  @override
  State<Reels> createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    const int pageCount = 10; 
    if (page == pageCount) {
      _pageController.jumpToPage(0);
    } else if (page == -1) {
      _pageController.jumpToPage(pageCount - 1);
    }
  }

  void _moveToNextPage() {
    if (_pageController.hasClients) {
      int nextPage = _pageController.page!.round() + 1;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: 10,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          return Reelspage(
            index: index,
            onVideoEnded: _moveToNextPage,
          );
        },
      ),
    );
  }
}
