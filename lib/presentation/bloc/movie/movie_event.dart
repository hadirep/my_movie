import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class OnMovieChanged extends MovieEvent {
  @override
  List<Object> get props => [];
}