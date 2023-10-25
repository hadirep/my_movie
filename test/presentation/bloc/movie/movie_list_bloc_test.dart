import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:my_movie/common/failure.dart';
import 'package:my_movie/domain/entities/movie/movie.dart';
import 'package:my_movie/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:my_movie/domain/usecases/movie/get_popular_movies.dart';
import 'package:my_movie/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:my_movie/presentation/bloc/movie/movie_event.dart';
import 'package:my_movie/presentation/bloc/movie/movie_state.dart';
import 'package:my_movie/presentation/bloc/movie/movie_list_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/popular_movies_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/top_rated_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc listBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late PopularMoviesBloc popularBloc;
  late MockGetPopularMovies mockGetPopularMovies;
  late TopRatedMoviesBloc topRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    listBloc = MovieListBloc(mockGetNowPlayingMovies);
    mockGetPopularMovies = MockGetPopularMovies();
    popularBloc = PopularMoviesBloc(mockGetPopularMovies);
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies', () {
    // Tidak ada data
    test('initialState should be Empty', () {
      expect(listBloc.state, MovieEmpty());
    });
    //Punya data
    blocTest<MovieListBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return listBloc;
      },
      act: (bloc) => bloc.add(OnMovieChanged()),
      expect: () => [
        MovieLoading(),
        MovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
    // MovieError
    blocTest<MovieListBloc, MovieState>(
      'Should emit [Loading, Error] when get movie list is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return listBloc;
      },
      act: (bloc) => bloc.add(OnMovieChanged()),
      expect: () => [
        MovieLoading(),
        const MovieError('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('Popular Movies', () {
    // Tidak ada data
    test('initialState should be Empty', () {
      expect(popularBloc.state, MovieEmpty());
    });
    //Punya data
    blocTest<PopularMoviesBloc, MovieState>(
      'Should emit [Loading, Data] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularBloc;
      },
      act: (bloc) => bloc.add(OnMovieChanged()),
      expect: () => [
        MovieLoading(),
        MovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
    // MovieError
    blocTest<PopularMoviesBloc, MovieState>(
      'Should emit [Loading, Error] when get movie list is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularBloc;
      },
      act: (bloc) => bloc.add(OnMovieChanged()),
      expect: () => [
        MovieLoading(),
        const MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group('Top Rated Movies', () {
    // Tidak ada data
    test('initialState should be Empty', () {
      expect(topRatedBloc.state, MovieEmpty());
    });
    //Punya data
    blocTest<TopRatedMoviesBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(OnMovieChanged()),
      expect: () => [
        MovieLoading(),
        MovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
    // MovieError
    blocTest<TopRatedMoviesBloc, MovieState>(
      'Should emit [Loading, Error] when get top rated movie list is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(OnMovieChanged()),
      expect: () => [
        MovieLoading(),
        const MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
