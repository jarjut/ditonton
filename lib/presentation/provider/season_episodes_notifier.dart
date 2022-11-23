import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/tvseries/get_season_episodes.dart';
import 'package:flutter/material.dart';

class SeasonEpisodesNotifier extends ChangeNotifier {
  final GetSeasonEpisodes getSeasonEpisodes;

  SeasonEpisodesNotifier({required this.getSeasonEpisodes});

  List<Episode> _episodeList = [];
  List<Episode> get episodeList => _episodeList;

  RequestState _episodeListState = RequestState.empty;
  RequestState get episodeListState => _episodeListState;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeasonEpisodes(int tvId, int seasonNumber) async {
    _episodeListState = RequestState.loading;
    notifyListeners();
    final result = await getSeasonEpisodes.execute(tvId, seasonNumber);
    result.fold(
      (error) {
        _episodeListState = RequestState.error;
        _message = error.message;
        notifyListeners();
      },
      (data) {
        _episodeListState = RequestState.loaded;
        _episodeList = data;
        notifyListeners();
      },
    );
  }
}
