import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_event.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_state.dart';

class PopularTVSeriesBloc extends Bloc<TVSeriesEvent, TVSeriesState> {
  final GetPopularTVSeries _getPopularTVSeries;

  PopularTVSeriesBloc(this._getPopularTVSeries) : super(TVSeriesEmpty()) {
    on<OnTVSeriesChanged>((event, emit) async {
      emit(TVSeriesLoading());
      final result = await _getPopularTVSeries.execute();

      result.fold(
        (failure) {
          emit(TVSeriesError(failure.message));
        },
        (data) {
          emit(TVSeriesHasData(data));
        },
      );
    });
  }
}