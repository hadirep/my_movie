import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_event.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_state.dart';

class TopRatedTVSeriesBloc extends Bloc<TVSeriesEvent, TVSeriesState> {
  final GetTopRatedTVSeries _getTopRatedTVSeries;

  TopRatedTVSeriesBloc(this._getTopRatedTVSeries) : super(TVSeriesEmpty()) {
    on<OnTVSeriesChanged>((event, emit) async {
      emit(TVSeriesLoading());
      final result = await _getTopRatedTVSeries.execute();

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
