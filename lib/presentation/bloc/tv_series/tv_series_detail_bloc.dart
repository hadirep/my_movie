import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/common/state_enum.dart';
import 'package:my_movie/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:my_movie/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:my_movie/domain/usecases/tv_series/get_watchlist_status.dart';
import 'package:my_movie/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:my_movie/domain/usecases/tv_series/save_watchlist.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_detail_event.dart';
import 'package:my_movie/presentation/bloc/tv_series/tv_series_detail_state.dart';

class TVSeriesDetailBloc extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  final GetTVSeriesDetail getTVSeriesDetail;
  final GetTVSeriesRecommendations getTVSeriesRecommendations;
  final GetWatchListStatusTVSeries getWatchListStatus;
  final SaveWatchlistTVSeries saveWatchlist;
  final RemoveWatchlistTVSeries removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TVSeriesDetailBloc(this.getTVSeriesDetail, this.getTVSeriesRecommendations,
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(TVSeriesDetailState.initial()) {
    on<OnDetailChanged>(
      (event, emit) async {
        emit(state.copyWith(detailState: RequestState.loading));
        final result = await getTVSeriesDetail.execute(event.id);
        final recommendationMovie =
            await getTVSeriesRecommendations.execute(event.id);

        result.fold(
          (failure) {
            emit(state.copyWith(
              detailState: RequestState.error,
              message: failure.message,
            ));
          },
          (detailMovie) {
            emit(state.copyWith(
              recommendationState: RequestState.loading,
              message: '',
              detailState: RequestState.hasData,
              detail: detailMovie,
            ));
            recommendationMovie.fold((failure) {
              emit(state.copyWith(
                recommendationState: RequestState.error,
                message: failure.message,
              ));
            }, (recommendation) {
              emit(state.copyWith(
                recommendations: recommendation,
                recommendationState: RequestState.hasData,
                message: '',
              ));
            });
          },
        );
      },
    );
    on<TVSeriesAddWatchlist>(
      (event, emit) async {
        final result = await saveWatchlist.execute(event.tvSeriesDetail);
        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (added) {
            emit(state.copyWith(
              watchlistMessage: watchlistAddSuccessMessage,
            ));
          },
        );
        add(TVSeriesWatchlistStatus(event.tvSeriesDetail.id));
      },
    );
    on<TVSeriesRemoveWatchlist>(
      (event, emit) async {
        final result = await removeWatchlist.execute(event.tvSeriesDetail);
        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (added) {
            emit(state.copyWith(
              watchlistMessage: watchlistRemoveSuccessMessage,
            ));
          },
        );
        add(TVSeriesWatchlistStatus(event.tvSeriesDetail.id));
      },
    );
    on<TVSeriesWatchlistStatus>(
      (event, emit) async {
        final result = await getWatchListStatus.execute(event.id);
        emit(state.copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
