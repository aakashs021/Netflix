import 'package:flutter/material.dart';
import 'package:netflix/screens/account/account.dart';
import 'package:netflix/screens/new_and_hot/presentation/news_and_hot.dart';
import 'package:netflix/screens/reels/presentation/reels.dart';
import 'package:netflix/screens/home/presentation/home.dart';
import 'package:netflix/styles/colors/colors.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int selectedIndex = 0;
  List<Widget> pages = [
    const Home(),
    const Reels(),
    const NewsandHot(),
    const Account()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        showUnselectedLabels: true,
        backgroundColor: black,
        selectedItemColor: white,
        unselectedItemColor: grey,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions_outlined),
            label: 'Fast laugh',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.next_week_rounded),
            label: 'News and hot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
