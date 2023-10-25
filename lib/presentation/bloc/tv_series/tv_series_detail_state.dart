import 'package:equatable/equatable.dart';
import 'package:my_movie/common/state_enum.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series_detail.dart';

class TVSeriesDetailState extends Equatable {
  final TVSeriesDetail? tvSeriesDetail;
  final List<TVSeries> tvSeriesRecommendations;
  final RequestState tvSeriesDetailState;
  final RequestState tvSeriesRecommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const TVSeriesDetailState({
    required this.tvSeriesDetail,
    required this.tvSeriesRecommendations,
    required this.tvSeriesDetailState,
    required this.tvSeriesRecommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  TVSeriesDetailState copyWith({
    TVSeriesDetail? detail,
    List<TVSeries>? recommendations,
    RequestState? detailState,
    RequestState? recommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return TVSeriesDetailState(
      tvSeriesDetail: detail ?? tvSeriesDetail,
      tvSeriesRecommendations: recommendations ?? tvSeriesRecommendations,
      tvSeriesDetailState: detailState ?? tvSeriesDetailState,
      tvSeriesRecommendationState:
          recommendationState ?? tvSeriesRecommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory TVSeriesDetailState.initial() {
    return const TVSeriesDetailState(
      tvSeriesDetail: null,
      tvSeriesRecommendations: [],
      tvSeriesDetailState: RequestState.empty,
      tvSeriesRecommendationState: RequestState.empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  @override
  List<Object?> get props => [
        tvSeriesDetail,
        tvSeriesRecommendations,
        tvSeriesDetailState,
        tvSeriesRecommendationState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
