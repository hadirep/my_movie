import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/common/state_enum.dart';
import 'package:my_movie/domain/usecases/movie/get_movie_detail.dart';
import 'package:my_movie/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:my_movie/domain/usecases/movie/get_watchlist_status.dart';
import 'package:my_movie/domain/usecases/movie/remove_watchlist.dart';
import 'package:my_movie/domain/usecases/movie/save_watchlist.dart';
import 'package:my_movie/presentation/bloc/movie/movie_detail_event.dart';
import 'package:my_movie/presentation/bloc/movie/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatusMovie getWatchListStatus;
  final SaveWatchlistMovie saveWatchlist;
  final RemoveWatchlistMovie removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailBloc(this.getMovieDetail, this.getMovieRecommendations,
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(MovieDetailState.initial()) {
    on<OnDetailChanged>(
      (event, emit) async {
        emit(state.copyWith(movieDetailState: RequestState.loading));
        final result = await getMovieDetail.execute(event.id);
        final recommendationMovie =
            await getMovieRecommendations.execute(event.id);

        result.fold(
          (failure) {
            emit(state.copyWith(
              movieDetailState: RequestState.error,
              message: failure.message,
            ));
          },
          (detailMovie) {
            emit(state.copyWith(
              movieRecommendationState: RequestState.loading,
              message: '',
              movieDetailState: RequestState.hasData,
              movieDetail: detailMovie,
            ));
            recommendationMovie.fold((failure) {
              emit(state.copyWith(
                movieRecommendationState: RequestState.error,
                message: failure.message,
              ));
            }, (recommendation) {
              emit(state.copyWith(
                movieRecommendations: recommendation,
                movieRecommendationState: RequestState.hasData,
                message: '',
              ));
            });
          },
        );
      },
    );
    on<MovieAddWatchlist>(
      (event, emit) async {
        final result = await saveWatchlist.execute(event.movieDetail);
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
        add(MovieWatchlistStatus(event.movieDetail.id));
      },
    );
    on<MovieRemoveWatchlist>(
      (event, emit) async {
        final result = await removeWatchlist.execute(event.movieDetail);
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
        add(MovieWatchlistStatus(event.movieDetail.id));
      },
    );
    on<MovieWatchlistStatus>(
      (event, emit) async {
        final result = await getWatchListStatus.execute(event.id);
        emit(state.copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
