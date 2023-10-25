import 'package:my_movie/common/constants.dart';
import 'package:my_movie/common/utils.dart';
import 'package:my_movie/presentation/pages/about_page.dart';
import 'package:my_movie/presentation/pages/home_page.dart';
import 'package:my_movie/presentation/pages/search_page.dart';

import 'package:my_movie/presentation/bloc/movie/movie_list_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/popular_movies_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/top_rated_movies_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/movie_detail_bloc.dart';

import 'package:my_movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:my_movie/presentation/pages/movie/popular_movies_page.dart';
import 'package:my_movie/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:my_movie/presentation/pages/movie/watchlist_movies_page.dart';

import 'package:my_movie/presentation/bloc/tv_series/tv_series_list_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_search_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/popular_tv_series_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/top_rated_tv_series_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_detail_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/watchlist_tv_series_bloc.dart';

import 'package:my_movie/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:my_movie/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:my_movie/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:my_movie/presentation/pages/tv_series/watchlist_tv_series_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_movie/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTVSeriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'My Movie',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const Material(
          child: HomePage(),
        ),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());

            case PopularTVSeriesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const PopularTVSeriesPage());
            case TopRatedTVSeriesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedTVSeriesPage());
            case TVSeriesDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVSeriesDetailPage(id: id),
                settings: settings,
              );
            case WatchlistTVSeriesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistTVSeriesPage());

            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
