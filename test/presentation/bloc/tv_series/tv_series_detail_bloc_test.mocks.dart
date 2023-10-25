// Mocks generated by Mockito 5.4.2 from annotations
// in my_movie/test/presentation/bloc/tv_series/tv_series_detail_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:my_movie/common/failure.dart' as _i6;
import 'package:my_movie/domain/entities/tv_series/tv_series.dart' as _i9;
import 'package:my_movie/domain/entities/tv_series/tv_series_detail.dart'
    as _i7;
import 'package:my_movie/domain/repositories/tv_series/tv_series_repository.dart'
    as _i2;
import 'package:my_movie/domain/usecases/tv_series/get_tv_series_detail.dart'
    as _i4;
import 'package:my_movie/domain/usecases/tv_series/get_tv_series_recommendations.dart'
    as _i8;
import 'package:my_movie/domain/usecases/tv_series/get_watchlist_status.dart'
    as _i10;
import 'package:my_movie/domain/usecases/tv_series/remove_watchlist.dart'
    as _i12;
import 'package:my_movie/domain/usecases/tv_series/save_watchlist.dart' as _i11;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTVSeriesRepository_0 extends _i1.SmartFake
    implements _i2.TVSeriesRepository {
  _FakeTVSeriesRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetTVSeriesDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTVSeriesDetail extends _i1.Mock implements _i4.GetTVSeriesDetail {
  MockGetTVSeriesDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTVSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TVSeriesRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TVSeriesDetail>> execute(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, _i7.TVSeriesDetail>>.value(
                _FakeEither_1<_i6.Failure, _i7.TVSeriesDetail>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.TVSeriesDetail>>);
}

/// A class which mocks [GetTVSeriesRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTVSeriesRecommendations extends _i1.Mock
    implements _i8.GetTVSeriesRecommendations {
  MockGetTVSeriesRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTVSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TVSeriesRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TVSeries>>> execute(dynamic id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i9.TVSeries>>>.value(
                _FakeEither_1<_i6.Failure, List<_i9.TVSeries>>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i9.TVSeries>>>);
}

/// A class which mocks [GetWatchListStatusTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusTVSeries extends _i1.Mock
    implements _i10.GetWatchListStatusTVSeries {
  MockGetWatchListStatusTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTVSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TVSeriesRepository);

  @override
  _i5.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [SaveWatchlistTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTVSeries extends _i1.Mock
    implements _i11.SaveWatchlistTVSeries {
  MockSaveWatchlistTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTVSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TVSeriesRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TVSeriesDetail? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tvSeries],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tvSeries],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTVSeries extends _i1.Mock
    implements _i12.RemoveWatchlistTVSeries {
  MockRemoveWatchlistTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTVSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TVSeriesRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TVSeriesDetail? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tvSeries],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tvSeries],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}
