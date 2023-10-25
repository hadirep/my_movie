import 'package:rxdart/rxdart.dart';
import 'package:my_movie/domain/usecases/tv_series/search_tv_series.dart';
import 'package:my_movie/presentation/bloc/search_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_state.dart';

class TVSeriesSearchBloc extends Bloc<SearchEvent, TVSeriesState> {
  final SearchTVSeries _searchTVSeries;

  TVSeriesSearchBloc(this._searchTVSeries) : super(TVSeriesEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TVSeriesLoading());
      final result = await _searchTVSeries.execute(query);

      result.fold(
        (failure) {
          emit(TVSeriesError(failure.message));
        },
        (data) {
          emit(TVSeriesHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
