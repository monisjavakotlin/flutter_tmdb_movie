import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tmdb_movie/screens/popular_list.dart';
import 'package:flutter_tmdb_movie/screens/top_rated_list.dart';
import 'package:flutter_tmdb_movie/screens/upcoming_list.dart';

import 'screens/now_playing_list.dart';

void main() {
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Plaing',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
//  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
//    _scrollViewController = ScrollController();
//    widget.name;
  }

  @override
  void dispose() {
    _tabController.dispose();
//    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
//        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerboxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: false,
              floating: false,
              snap: false,
//              forceElevated: innerboxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Movie Intro',
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverPersistentHeaderDelegate(TabBar(
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: <Widget>[
                  Tab(text: 'Playing', icon: Icon(Icons.local_movies)),
                  Tab(text: 'Rated', icon: Icon(Icons.rate_review)),
                  Tab(text: 'Popular', icon: Icon(Icons.person)),
                  Tab(text: 'Upcoming', icon: Icon(Icons.category))
                ],
              )),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            NowPlayingList(),
            TopRatedList(),
            PopularList(),
            UpcomingList(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverPersistentHeaderDelegate(this._tabBar);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
      color: Colors.white,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
