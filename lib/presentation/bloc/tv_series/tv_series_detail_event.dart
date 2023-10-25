import 'package:equatable/equatable.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series_detail.dart';

abstract class TVSeriesDetailEvent extends Equatable {
  const TVSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class OnDetailChanged extends TVSeriesDetailEvent {
  final int id;

  const OnDetailChanged(this.id);

  @override
  List<Object> get props => [id];
}

class TVSeriesAddWatchlist extends TVSeriesDetailEvent {
  final TVSeriesDetail tvSeriesDetail;

  const TVSeriesAddWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class TVSeriesRemoveWatchlist extends TVSeriesDetailEvent {
  final TVSeriesDetail tvSeriesDetail;

  const TVSeriesRemoveWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class TVSeriesWatchlistStatus extends TVSeriesDetailEvent {
  final int id;

  const TVSeriesWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
