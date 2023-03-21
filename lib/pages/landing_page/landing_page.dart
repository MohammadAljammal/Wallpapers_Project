import 'package:flutter/material.dart';
import 'package:josequal/components/bottom_navigation/bottom_navigation.dart';
import 'package:josequal/pages/explore_page/explore_page.dart';
import 'package:josequal/pages/favorite_page/favorite_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentTab = 0;
  PageController? pageController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> pagesTitle = ['Explore', 'Favorite'];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          pagesTitle[currentTab],
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [ExplorePage(), FavoritePage()],
              onPageChanged: (val) {
                setState(() {
                  currentTab = val;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 0.1, color: Theme.of(context).dividerColor))),
          child: BottomNavBar(
            changeIndex: changeCurrentTab,
            index: currentTab,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  changeCurrentTab(int tab) {
    setState(() {
      if (currentTab != tab) {
        pageController!.jumpToPage(tab);
        currentTab = tab;
      }
    });
  }
}
