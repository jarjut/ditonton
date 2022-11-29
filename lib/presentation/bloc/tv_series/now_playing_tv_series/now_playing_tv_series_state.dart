part of 'now_playing_tv_series_cubit.dart';

abstract class NowPlayingTvSeriesState extends Equatable {
  const NowPlayingTvSeriesState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvSeriesInitial extends NowPlayingTvSeriesState {}

class NowPlayingTvSeriesLoading extends NowPlayingTvSeriesState {}

class NowPlayingTvSeriesLoaded extends NowPlayingTvSeriesState {
  final List<TvSeries> tvSeries;

  const NowPlayingTvSeriesLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class NowPlayingTvSeriesError extends NowPlayingTvSeriesState {
  final String message;

  const NowPlayingTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
