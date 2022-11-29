part of 'season_episodes_cubit.dart';

abstract class SeasonEpisodesState extends Equatable {
  const SeasonEpisodesState();

  @override
  List<Object> get props => [];
}

class SeasonEpisodesInitial extends SeasonEpisodesState {
  const SeasonEpisodesInitial();
}

class SeasonEpisodesLoading extends SeasonEpisodesState {
  const SeasonEpisodesLoading();
}

class SeasonEpisodesLoaded extends SeasonEpisodesState {
  final List<Episode> episodes;

  const SeasonEpisodesLoaded(this.episodes);

  @override
  List<Object> get props => [episodes];
}

class SeasonEpisodesError extends SeasonEpisodesState {
  final String message;

  const SeasonEpisodesError(this.message);

  @override
  List<Object> get props => [message];
}
