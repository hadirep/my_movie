import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/bloc/movie/movie_event.dart';
import 'package:my_movie/presentation/bloc/movie/movie_state.dart';
import '../../../domain/usecases/movie/get_watchlist_movies.dart';

class WatchlistMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies _getWatchlist;

  WatchlistMovieBloc(this._getWatchlist) : super(MovieEmpty()) {
    on<OnMovieChanged>(
      (event, emit) async {
        emit(MovieLoading());
        final result = await _getWatchlist.execute();
        result.fold(
          (failure) {
            emit(MovieError(failure.message));
          },
          (data) {
            emit(MovieHasData(data));
          },
        );
      },
    );
  }
}
