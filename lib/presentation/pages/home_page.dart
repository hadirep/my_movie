import 'package:flutter/material.dart';
import 'package:my_movie/common/constants.dart';
import 'package:my_movie/presentation/pages/about_page.dart';
import 'package:my_movie/presentation/pages/movie/home_movie_page.dart';
import 'package:my_movie/presentation/pages/search_page.dart';
import 'package:my_movie/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:my_movie/presentation/pages/tv_series/home_tv_series_page.dart';
import 'package:my_movie/presentation/pages/tv_series/watchlist_tv_series_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _tvSeriesText = 'TV Series';
  static const String _movieText = 'Movie';

  final List<Widget> _listWidget = [
    const HomeMoviePage(),
    const HomeTVSeriesPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.movie_creation_outlined),
      label: _movieText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.tv),
      label: _tvSeriesText,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/logo-circle.png'),
              ),
              accountName: Text('My Movie'),
              accountEmail: Text('hadiesarahma@gmail.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie_creation_outlined),
              title: const Text('Watchlist Movie'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Watchlist TV Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTVSeriesPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kMikadoYellow,
        unselectedItemColor: Colors.white,
        currentIndex: _bottomNavIndex,
        backgroundColor: kRichBlack,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
