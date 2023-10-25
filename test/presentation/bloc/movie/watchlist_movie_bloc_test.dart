import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:my_movie/common/failure.dart';
import 'package:my_movie/domain/entities/movie/movie.dart';
import 'package:my_movie/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:my_movie/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/movie_event.dart';
import 'package:my_movie/presentation/bloc/movie/movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_objects_movie.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  final tMovies = <Movie>[testMovie];

  test('Initial state should be empty', () {
    expect(watchlistBloc.state, MovieEmpty());
  });

  blocTest<WatchlistMovieBloc, MovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovies));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnMovieChanged()),
    expect: () => [
      MovieLoading(),
      MovieHasData(tMovies),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, MovieState>(
    'Should emit [Loading, HasData, Empty] when data is empty',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Right(<Movie>[]));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnMovieChanged()),
    expect: () => [
      MovieLoading(),
      const MovieHasData(<Movie>[]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, MovieState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnMovieChanged()),
    expect: () => [
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
