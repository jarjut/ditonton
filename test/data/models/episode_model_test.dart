import 'package:ditonton/data/models/episode_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EpisodeModel', () {
    final tEpisodeModel = EpisodeModel(
      id: 1,
      episodeNumber: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      showId: 1,
      voteAverage: 1,
      voteCount: 1,
      airDate: DateTime(2020, 2, 2),
      stillPath: 'stillPath',
    );

    const tEpisodeJson = {
      "id": 1,
      "episode_number": 1,
      "name": "name",
      "overview": "overview",
      "production_code": "productionCode",
      "season_number": 1,
      "show_id": 1,
      "vote_average": 1,
      "vote_count": 1,
      "air_date": "2020-02-02",
      "still_path": "stillPath",
    };

    test('fromJson', () {
      expect(tEpisodeModel, EpisodeModel.fromJson(tEpisodeJson));
    });

    test('toJson', () {
      expect(tEpisodeJson, tEpisodeModel.toJson());
    });
  });
}
