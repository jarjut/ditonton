import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'tv_series_recommendation_state.dart';

@injectable
class TvSeriesRecommendationCubit extends Cubit<TvSeriesRecommendationState> {
  TvSeriesRecommendationCubit(this.getTvRecommendations)
      : super(const TvSeriesRecommendationInitial());

  final GetTvRecommendations getTvRecommendations;

  Future<void> fetchTvSeriesRecommendation(int id) async {
    emit(const TvSeriesRecommendationLoading());
    final result = await getTvRecommendations.execute(id);
    result.fold(
      (failure) => emit(TvSeriesRecommendationError(failure.message)),
      (data) => emit(TvSeriesRecommendationLoaded(data)),
    );
  }
}
