import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_event.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_state.dart';

class WatchlistTVSeriesBloc extends Bloc<TVSeriesEvent, TVSeriesState> {
  final GetWatchlistTVSeries _getWatchlist;

  WatchlistTVSeriesBloc(this._getWatchlist) : super(TVSeriesEmpty()) {
    on<OnTVSeriesChanged>(
      (event, emit) async {
        emit(TVSeriesLoading());
        final result = await _getWatchlist.execute();
        result.fold(
          (failure) {
            emit(TVSeriesError(failure.message));
          },
          (data) {
            emit(TVSeriesHasData(data));
          },
        );
      },
    );
  }
}
