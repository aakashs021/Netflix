import 'package:flutter/material.dart';
import 'package:netflix/screens/new_and_hot/widgets/tabbarcontent2.dart';
import 'package:netflix/screens/new_and_hot/widgets/tabbarcontent1.dart';
import 'package:netflix/screens/new_and_hot/widgets/tabofnew.dart';
import 'package:netflix/screens/search/presentation/search.dart';
import 'package:netflix/screens/new_and_hot/widgets/tabbarcontent3.dart';

class NewsandHot extends StatefulWidget {
  const NewsandHot({super.key});

  @override
  State<NewsandHot> createState() => _NewsandHotState();
}

class _NewsandHotState extends State<NewsandHot>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ScrollController scrollController;

  final double sectionHeight = 3600.0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    scrollController = ScrollController();

    scrollController.addListener(() {
      double offset = scrollController.offset;
      int tabIndex = (offset / sectionHeight).floor();
      if (tabController.index != tabIndex) {
        setState(() {
          tabController.index = tabIndex;
        });
      }
    });

    // Add listener to update tab color when the tab is changed programmatically
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('News & Hot'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Searchpage(),
              ));
            },
            icon: const Icon(
              Icons.search,
              size: 35,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Colors.black, // Color for the tab bar
            child: TabBar(
              tabAlignment: TabAlignment.start,
              labelPadding: const EdgeInsets.only(left: 15),
              dividerColor: Colors.transparent,
              isScrollable: true,
              controller: tabController,
              indicator: const BoxDecoration(), // Remove the indicator
              onTap: (index) {
                // Set the current index when a tab is tapped
                tabController.index = index;
                double targetOffset = index * sectionHeight;
                scrollController.animateTo(
                  targetOffset,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              // Set label color based on current index
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.white,
              tabs: [
                tabOfNew(
                  current: tabController.index,
                  number: 0,
                  tabTitle: '🍿 Coming Soon',
                ),
                tabOfNew(
                  current: tabController.index,
                  number: 1,
                  tabTitle: "🔥 Everyone's Watching",
                ),
                tabOfNew(
                  current: tabController.index,
                  number: 2,
                  tabTitle: 'Top 10 Movies',
                ),
              ],
            ),
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
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
          child: Column(
            children: [
              SizedBox(height: sectionHeight, child: const Tabbarcontent1()),
              SizedBox(height: sectionHeight, child: const Tabbarcontent2()),
              SizedBox(height: sectionHeight, child: const Tabbarcontent3()),
            ],
          ),
        ),
      ),
    );
  }
}
