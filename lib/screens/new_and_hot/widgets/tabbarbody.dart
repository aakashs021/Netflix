import 'package:flutter/material.dart';
import 'package:netflix/screens/new_and_hot/widgets/tabbarcontent1.dart';
import 'package:netflix/screens/new_and_hot/widgets/tabbarcontent2.dart';
import 'package:netflix/screens/new_and_hot/widgets/tabbarcontent3.dart';

class Tabbarbody extends StatefulWidget {
final ScrollController scrollController;
final double sectionHeight;
final TabController tabController;

   const Tabbarbody({super.key, required this.scrollController, required this.sectionHeight, required this.tabController});

  @override
  State<Tabbarbody> createState() => _TabbarbodyState();
}

class _TabbarbodyState extends State<Tabbarbody> {
late ScrollController scrollController;
late TabController tabController;
late double sectionHeight;

  @override
  void initState() {
    super.initState();
    scrollController=widget.scrollController;
    tabController=widget.tabController;
    sectionHeight=widget.sectionHeight;
    
  }
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollNotification) {
        if (scrollNotification is ScrollUpdateNotification) {
          int tabIndex = (scrollController.offset / sectionHeight).floor();
          if (tabController.index != tabIndex) {
            setState(() {
              tabController.index = tabIndex;
            });
          }
        }
        return true;
      },
      child: SingleChildScrollView(
        controller: scrollController,
        child: const Column(
          children: [
            Tabbarcontent1(),
            Tabbarcontent2(),
            Tabbarcontent3()
          ],
        ),
      ),
    );
  }
}