import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'popular_tv_series_state.dart';

@injectable
class PopularTvSeriesCubit extends Cubit<PopularTvSeriesState> {
  PopularTvSeriesCubit(this.getPopularTvSeries)
      : super(PopularTvSeriesInitial());

  final GetPopularTvSeries getPopularTvSeries;

  Future<void> fetchPopularTvSeries() async {
    emit(PopularTvSeriesLoading());
    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) => emit(PopularTvSeriesError(failure.message)),
      (data) => emit(PopularTvSeriesLoaded(data)),
    );
  }
}
