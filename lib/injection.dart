import 'package:my_movie/data/datasources/db/movie/database_helper.dart';
import 'package:my_movie/data/datasources/movie/movie_local_data_source.dart';
import 'package:my_movie/data/datasources/movie/movie_remote_data_source.dart';

import 'package:my_movie/data/datasources/db/tv_series/database_helper.dart';
import 'package:my_movie/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:my_movie/data/datasources/tv_series/tv_series_remote_data_source.dart';

import 'package:my_movie/data/repositories/movie/movie_repository_impl.dart';
import 'package:my_movie/domain/repositories/movie/movie_repository.dart';

import 'package:my_movie/data/repositories/tv_series/tv_series_repository_impl.dart';
import 'package:my_movie/domain/repositories/tv_series/tv_series_repository.dart';

import 'package:my_movie/domain/usecases/movie/get_movie_detail.dart';
import 'package:my_movie/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:my_movie/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:my_movie/domain/usecases/movie/get_popular_movies.dart';
import 'package:my_movie/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:my_movie/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:my_movie/domain/usecases/movie/get_watchlist_status.dart';
import 'package:my_movie/domain/usecases/movie/remove_watchlist.dart';
import 'package:my_movie/domain/usecases/movie/save_watchlist.dart';
import 'package:my_movie/domain/usecases/movie/search_movies.dart';

import 'package:my_movie/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:my_movie/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:my_movie/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:my_movie/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:my_movie/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:my_movie/domain/usecases/tv_series/get_watchlist_status.dart';
import 'package:my_movie/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:my_movie/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:my_movie/domain/usecases/tv_series/save_watchlist.dart';
import 'package:my_movie/domain/usecases/tv_series/search_tv_series.dart';

import 'package:my_movie/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/movie_list_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/popular_movies_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/top_rated_movies_bloc.dart';

import 'package:my_movie/presentation/bloc/tv_series/tv_series_search_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/watchlist_tv_series_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/popular_tv_series_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/top_rated_tv_series_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_list_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_detail_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider movie
  locator.registerFactory(
    () => MovieListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  // mendaftarkan dependency dengan metode factory
  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      locator(),
    ),
  );

  // provider tv series
  locator.registerFactory(
    () => TVSeriesListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TVSeriesDetailBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TVSeriesSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTVSeriesBloc(
      locator(),
    ),
  );

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv series
  locator.registerLazySingleton(() => GetNowPlayingTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTVSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeries(locator()));

  // repository movie // mendaftarkan dependency dengan metode LazySingleton
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // repository tv series
  locator.registerLazySingleton<TVSeriesRepository>(
    () => TVSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources tv series
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
      () => TVSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
      () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper movie
  locator
      .registerLazySingleton<DatabaseHelperMovie>(() => DatabaseHelperMovie());

  // helper tv series
  locator.registerLazySingleton<DatabaseHelperTVSeries>(
      () => DatabaseHelperTVSeries());

  // external
  locator.registerLazySingleton(() => http.Client());
}
