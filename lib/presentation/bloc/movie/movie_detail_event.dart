import 'package:equatable/equatable.dart';
import 'package:my_movie/domain/entities/movie/movie_detail.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnDetailChanged extends MovieDetailEvent {
  final int id;

  const OnDetailChanged(this.id);

  @override
  List<Object> get props => [id];
}

class MovieAddWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const MovieAddWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class MovieRemoveWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const MovieRemoveWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class MovieWatchlistStatus extends MovieDetailEvent {
  final int id;

  const MovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
