import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'top_rated_tv_series_state.dart';

@injectable
class TopRatedTvSeriesCubit extends Cubit<TopRatedTvSeriesState> {
  TopRatedTvSeriesCubit(this.getTopRatedTvSeries)
      : super(TopRatedTvSeriesInitial());

  final GetTopRatedTvSeries getTopRatedTvSeries;

  Future<void> fetchTopRatedTvSeries() async {
    emit(TopRatedTvSeriesLoading());
    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) => emit(TopRatedTvSeriesError(failure.message)),
      (data) => emit(TopRatedTvSeriesLoaded(data)),
    );
  }
}
