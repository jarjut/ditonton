part of 'movie_recommendation_cubit.dart';

abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationInitial extends MovieRecommendationState {
  const MovieRecommendationInitial();
}

class MovieRecommendationLoading extends MovieRecommendationState {
  const MovieRecommendationLoading();
}

class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<Movie> movies;

  const MovieRecommendationLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;

  const MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
