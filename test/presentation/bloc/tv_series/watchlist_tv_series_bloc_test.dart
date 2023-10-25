import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:my_movie/common/failure.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series.dart';
import 'package:my_movie/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:my_movie/presentation/bloc/tv_series/watchlist_tv_series_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_event.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_objects_tv_series.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTVSeries])
void main() {
  late WatchlistTVSeriesBloc watchlistBloc;
  late MockGetWatchlistTVSeries mockGetWatchlistTVSeries;

  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistTVSeries();
    watchlistBloc = WatchlistTVSeriesBloc(mockGetWatchlistTVSeries);
  });

  final tTVSeries = <TVSeries>[testTVSeries];

  test('Initial state should be empty', () {
    expect(watchlistBloc.state, TVSeriesEmpty());
  });

  blocTest<WatchlistTVSeriesBloc, TVSeriesState>(
    'Should emit [WatchlistLoading, WatchlistHasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeries));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesChanged()),
    expect: () => [
      TVSeriesLoading(),
      TVSeriesHasData(tTVSeries),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );

  blocTest<WatchlistTVSeriesBloc, TVSeriesState>(
    'Should emit [WatchlistLoading, WatchlistHasData[], WatchlistEmpty] when data is empty',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => const Right(<TVSeries>[]));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesChanged()),
    expect: () => [
      TVSeriesLoading(),
      const TVSeriesHasData(<TVSeries>[]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );

  blocTest<WatchlistTVSeriesBloc, TVSeriesState>(
    'Should emit [WatchlistLoading, WatchlistError] when data is unsuccessful',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnTVSeriesChanged()),
    expect: () => [
      TVSeriesLoading(),
      const TVSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );
}
