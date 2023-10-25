import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:my_movie/presentation/bloc/movie/movie_event.dart';
import 'package:my_movie/presentation/bloc/movie/movie_state.dart';

class MovieListBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieListBloc(this._getNowPlayingMovies) : super(MovieEmpty()) {
    on<OnMovieChanged>((event, emit) async {
      emit(MovieLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(MovieHasData(data));
        },
      );
    });
  }
}
