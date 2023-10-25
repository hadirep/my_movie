import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_movie/common/state_enum.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series.dart';
import 'package:my_movie/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_detail_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_detail_event.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_detail_state.dart';

import '../../../dummy_data/tv_series/dummy_objects_tv_series.dart';

class TVSeriesDetailEventFake extends Fake implements TVSeriesDetailEvent {}

class TVSeriesDetailStateFake extends Fake implements TVSeriesDetailState {}

class MockDetailTVSeriesBloc
    extends MockBloc<TVSeriesDetailEvent, TVSeriesDetailState>
    implements TVSeriesDetailBloc {}

void main() {
  late MockDetailTVSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(TVSeriesDetailEventFake());
    registerFallbackValue(TVSeriesDetailEventFake());
  });

  setUp(() {
    mockBloc = MockDetailTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVSeriesDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TVSeriesDetailState.initial()
        .copyWith(detailState: RequestState.loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester
        .pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display loading when recommendationState loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(TVSeriesDetailState.initial().copyWith(
      detailState: RequestState.hasData,
      detail: testTVSeriesDetail,
      recommendationState: RequestState.loading,
      recommendations: <TVSeries>[],
      isAddedToWatchlist: false,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester
        .pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(id: 1)));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(TVSeriesDetailState.initial().copyWith(
      detailState: RequestState.hasData,
      detail: testTVSeriesDetail,
      recommendationState: RequestState.hasData,
      recommendations: [testTVSeries],
      isAddedToWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when tv series is added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(TVSeriesDetailState.initial().copyWith(
      detailState: RequestState.hasData,
      detail: testTVSeriesDetail,
      recommendationState: RequestState.hasData,
      recommendations: [testTVSeries],
      isAddedToWatchlist: true,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockBloc,
        Stream.fromIterable([
          TVSeriesDetailState.initial().copyWith(
            detailState: RequestState.hasData,
            detail: testTVSeriesDetail,
            recommendationState: RequestState.hasData,
            recommendations: [testTVSeries],
            isAddedToWatchlist: false,
          ),
          TVSeriesDetailState.initial().copyWith(
            detailState: RequestState.hasData,
            detail: testTVSeriesDetail,
            recommendationState: RequestState.hasData,
            recommendations: [testTVSeries],
            isAddedToWatchlist: false,
            watchlistMessage: 'Added to Watchlist',
          ),
        ]),
        initialState: TVSeriesDetailState.initial());
    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockBloc,
        Stream.fromIterable([
          TVSeriesDetailState.initial().copyWith(
            detailState: RequestState.hasData,
            detail: testTVSeriesDetail,
            recommendationState: RequestState.hasData,
            recommendations: [testTVSeries],
            isAddedToWatchlist: false,
          ),
          TVSeriesDetailState.initial().copyWith(
            detailState: RequestState.hasData,
            detail: testTVSeriesDetail,
            recommendationState: RequestState.hasData,
            recommendations: [testTVSeries],
            isAddedToWatchlist: false,
            watchlistMessage: 'Removed from Watchlist',
          ),
        ]),
        initialState: TVSeriesDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    whenListen(
        mockBloc,
        Stream.fromIterable([
          TVSeriesDetailState.initial().copyWith(
            detailState: RequestState.hasData,
            detail: testTVSeriesDetail,
            recommendationState: RequestState.hasData,
            recommendations: [testTVSeries],
            isAddedToWatchlist: false,
          ),
          TVSeriesDetailState.initial().copyWith(
            detailState: RequestState.hasData,
            detail: testTVSeriesDetail,
            recommendationState: RequestState.hasData,
            recommendations: [testTVSeries],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed',
          ),
          TVSeriesDetailState.initial().copyWith(
            detailState: RequestState.hasData,
            detail: testTVSeriesDetail,
            recommendationState: RequestState.hasData,
            recommendations: [testTVSeries],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed ',
          ),
        ]),
        initialState: TVSeriesDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Detail Movie Page should display Error Text when No Internet Network (Error)',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TVSeriesDetailState.initial()
        .copyWith(
            detailState: RequestState.error,
            message: 'Failed to connect to the network'));

    final textErrorBarFinder = find.text('Failed to connect to the network');

    await tester
        .pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(id: 1)));
    await tester.pump();

    expect(textErrorBarFinder, findsOneWidget);
  });
}
