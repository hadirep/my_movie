import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:my_movie/common/state_enum.dart';
import 'package:my_movie/common/failure.dart';
import 'package:my_movie/domain/entities/genre.dart';
import 'package:my_movie/domain/usecases/tv_series/get_watchlist_status.dart';
import 'package:my_movie/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:my_movie/domain/usecases/tv_series/save_watchlist.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series_detail.dart';
import 'package:my_movie/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:my_movie/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_detail_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_detail_event.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVSeriesDetail,
  GetTVSeriesRecommendations,
  GetWatchListStatusTVSeries,
  SaveWatchlistTVSeries,
  RemoveWatchlistTVSeries,
])
void main() {
  late TVSeriesDetailBloc detailBloc;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;
  late MockGetWatchListStatusTVSeries mockGetWatchlistStatus;
  late MockSaveWatchlistTVSeries mockSaveWatchlist;
  late MockRemoveWatchlistTVSeries mockRemoveWatchlist;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatusTVSeries();
    mockSaveWatchlist = MockSaveWatchlistTVSeries();
    mockRemoveWatchlist = MockRemoveWatchlistTVSeries();
    detailBloc = TVSeriesDetailBloc(
      mockGetTVSeriesDetail,
      mockGetTVSeriesRecommendations,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  const tId = 1;
  final tvSeriesDetailStateInit = TVSeriesDetailState.initial();
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
  final tTVSeries1 = <TVSeries>[tTVSeries];

  final tTVSeriesDetail = TVSeriesDetail(
    backdropPath: 'backdropPath',
    genres: const [Genre(id: 1, name: 'Comedy')],
    id: 1,
    name: 'name',
    popularity: 1.0,
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  group('Get TV Series Detail', () {
    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Shoud emit TVSeriesDetail, Recomendations, MovieDetail and Recomendation when get  Detail TV Series and Recommendation Success',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(tTVSeriesDetail));
        when(mockGetTVSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTVSeries1));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const OnDetailChanged(tId)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(
            detailState: RequestState.loading),
        tvSeriesDetailStateInit.copyWith(
          recommendationState: RequestState.loading,
          detail: tTVSeriesDetail,
          detailState: RequestState.hasData,
          message: '',
        ),
        tvSeriesDetailStateInit.copyWith(
          detailState: RequestState.hasData,
          detail: tTVSeriesDetail,
          recommendationState: RequestState.hasData,
          recommendations: tTVSeries1,
          message: '',
        ),
      ],
      verify: (_) {
        verify(mockGetTVSeriesDetail.execute(tId));
        verify(mockGetTVSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Shoud emit Detail TVSeries, Recomendations, DetailLoaded and RecommendationError when Get MovieRecommendations Failed',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(tTVSeriesDetail));
        when(mockGetTVSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const OnDetailChanged(tId)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(
            detailState: RequestState.loading),
        tvSeriesDetailStateInit.copyWith(
          recommendationState: RequestState.loading,
          detail: tTVSeriesDetail,
          detailState: RequestState.hasData,
          message: '',
        ),
        tvSeriesDetailStateInit.copyWith(
          detailState: RequestState.hasData,
          detail: tTVSeriesDetail,
          recommendationState: RequestState.error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetTVSeriesDetail.execute(tId));
        verify(mockGetTVSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Shoud emit TV Series Detail Error when Get TV Series Detail Failed',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        when(mockGetTVSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTVSeries1));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const OnDetailChanged(tId)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(
            detailState: RequestState.loading),
        tvSeriesDetailStateInit.copyWith(
            detailState: RequestState.error, message: 'Failed'),
      ],
      verify: (_) {
        verify(mockGetTVSeriesDetail.execute(tId));
        verify(mockGetTVSeriesRecommendations.execute(tId));
      },
    );
  });

  group('AddToWatchlist Movie', () {
    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist True when Success AddWatchlist',
      build: () {
        when(mockSaveWatchlist.execute(tTVSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(tTVSeriesDetail.id))
            .thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add(TVSeriesAddWatchlist(tTVSeriesDetail)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(
            watchlistMessage: 'Added to Watchlist'),
        tvSeriesDetailStateInit.copyWith(
            watchlistMessage: 'Added to Watchlist', isAddedToWatchlist: true),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tTVSeriesDetail));
        verify(mockGetWatchlistStatus.execute(tTVSeriesDetail.id));
      },
    );

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockSaveWatchlist.execute(tTVSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(tTVSeriesDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(TVSeriesAddWatchlist(tTVSeriesDetail)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tTVSeriesDetail));
        verify(mockGetWatchlistStatus.execute(tTVSeriesDetail.id));
      },
    );
  });

  group('RemoveFromWatchlist TVSeries', () {
    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockRemoveWatchlist.execute(tTVSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(tTVSeriesDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(TVSeriesRemoveWatchlist(tTVSeriesDetail)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(tTVSeriesDetail));
        verify(mockGetWatchlistStatus.execute(tTVSeriesDetail.id));
      },
    );
  });

  group('LoadWatchlistStatus  TV Series', () {
    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should Emit AddWatchlistStatus True',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const TVSeriesWatchlistStatus(tId)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(isAddedToWatchlist: true),
      ],
      verify: (_) {
        verify(mockGetWatchlistStatus.execute(tTVSeriesDetail.id));
      },
    );
  });
}
