import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'now_playing_tv_series_state.dart';

@injectable
class NowPlayingTvSeriesCubit extends Cubit<NowPlayingTvSeriesState> {
  NowPlayingTvSeriesCubit(this.getNowPlayingTvSeries)
      : super(NowPlayingTvSeriesInitial());

  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  Future<void> fetchNowPlayingTvSeries() async {
    emit(NowPlayingTvSeriesLoading());
    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) => emit(NowPlayingTvSeriesError(failure.message)),
      (data) => emit(NowPlayingTvSeriesLoaded(data)),
    );
  }
}
