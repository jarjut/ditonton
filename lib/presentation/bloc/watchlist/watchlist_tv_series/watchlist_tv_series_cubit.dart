import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'watchlist_tv_series_state.dart';

@injectable
class WatchlistTvSeriesCubit extends Cubit<WatchlistTvSeriesState> {
  WatchlistTvSeriesCubit(this.getWatchlistTvSeries)
      : super(WatchlistTvSeriesInitial());

  final GetWatchlistTvSeries getWatchlistTvSeries;

  Future<void> fetchWatchlistTvSeries() async {
    emit(WatchlistTvSeriesLoading());
    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) => emit(WatchlistTvSeriesError(failure.message)),
      (tvSeriesData) => emit(WatchlistTvSeriesLoaded(tvSeriesData)),
    );
  }
}
