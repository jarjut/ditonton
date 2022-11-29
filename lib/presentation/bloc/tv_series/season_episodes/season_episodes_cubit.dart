import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/tvseries/get_season_episodes.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'season_episodes_state.dart';

@injectable
class SeasonEpisodesCubit extends Cubit<SeasonEpisodesState> {
  SeasonEpisodesCubit(this.getSeasonEpisodes)
      : super(const SeasonEpisodesInitial());

  final GetSeasonEpisodes getSeasonEpisodes;

  Future<void> fetchSeasonEpisodes(int tvId, int seasonNumber) async {
    emit(const SeasonEpisodesLoading());
    final result = await getSeasonEpisodes.execute(tvId, seasonNumber);
    result.fold(
      (failure) => emit(SeasonEpisodesError(failure.message)),
      (data) => emit(SeasonEpisodesLoaded(data)),
    );
  }
}
