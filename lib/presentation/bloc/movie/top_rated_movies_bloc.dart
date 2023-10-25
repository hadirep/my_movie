import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:my_movie/presentation/bloc/movie/movie_event.dart';
import 'package:my_movie/presentation/bloc/movie/movie_state.dart';

class TopRatedMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(MovieEmpty()) {
    on<OnMovieChanged>((event, emit) async {
      emit(MovieLoading());
      final result = await _getTopRatedMovies.execute();

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
