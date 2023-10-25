import 'package:rxdart/rxdart.dart';
import 'package:my_movie/domain/usecases/movie/search_movies.dart';
import 'package:my_movie/presentation/bloc/movie/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/bloc/search_event.dart';

class MovieSearchBloc extends Bloc<SearchEvent, MovieState> {
  final SearchMovies _searchMovies;

  MovieSearchBloc(this._searchMovies) : super(MovieEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(MovieLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(MovieHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
