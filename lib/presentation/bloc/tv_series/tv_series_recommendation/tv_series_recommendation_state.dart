part of 'tv_series_recommendation_cubit.dart';

abstract class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationInitial extends TvSeriesRecommendationState {
  const TvSeriesRecommendationInitial();
}

class TvSeriesRecommendationLoading extends TvSeriesRecommendationState {
  const TvSeriesRecommendationLoading();
}

class TvSeriesRecommendationLoaded extends TvSeriesRecommendationState {
  final List<TvSeries> tvSeries;

  const TvSeriesRecommendationLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TvSeriesRecommendationError extends TvSeriesRecommendationState {
  final String message;

  const TvSeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
