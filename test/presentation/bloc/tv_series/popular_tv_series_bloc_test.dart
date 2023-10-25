import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:my_movie/common/failure.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series.dart';
import 'package:my_movie/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_event.dart';
import 'package:my_movie/presentation/bloc/tv_series/popular_tv_series_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late PopularTVSeriesBloc popularBloc;

  setUp(() {
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    popularBloc = PopularTVSeriesBloc(mockGetPopularTVSeries);
  });

  final tTVSeries = TVSeries(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <TVSeries>[tTVSeries];
  // Tidak ada data
  test('initial state should be empty', () {
    expect(popularBloc.state, TVSeriesEmpty());
  });
  // Ada data
  blocTest<PopularTVSeriesBloc, TVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesChanged()),
    expect: () => [
      TVSeriesLoading(),
      TVSeriesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVSeries.execute());
    },
  );
  // Error
  blocTest<PopularTVSeriesBloc, TVSeriesState>(
    'Should emit [Loading, Error] when get popular tv series is unsuccessful',
    build: () {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesChanged()),
    expect: () => [
      TVSeriesLoading(),
      const TVSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVSeries.execute());
    },
  );
}
