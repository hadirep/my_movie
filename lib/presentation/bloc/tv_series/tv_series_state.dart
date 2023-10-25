import 'package:equatable/equatable.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series.dart';

abstract class TVSeriesState extends Equatable {
  const TVSeriesState();

  @override
  List<Object> get props => [];
}

class TVSeriesEmpty extends TVSeriesState {}

class TVSeriesLoading extends TVSeriesState {}

class TVSeriesError extends TVSeriesState {
  final String message;

  const TVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesHasData extends TVSeriesState {
  final List<TVSeries> result;

  const TVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
