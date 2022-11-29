import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'movie_recommendation_state.dart';

@injectable
class MovieRecommendationCubit extends Cubit<MovieRecommendationState> {
  MovieRecommendationCubit({required this.getMovieRecommendations})
      : super(const MovieRecommendationInitial());

  final GetMovieRecommendations getMovieRecommendations;

  Future<void> fetchMovieRecommendations(int id) async {
    emit(const MovieRecommendationLoading());
    final result = await getMovieRecommendations.execute(id);
    result.fold(
      (failure) => emit(MovieRecommendationError(failure.message)),
      (movies) => emit(MovieRecommendationLoaded(movies)),
    );
  }
}
