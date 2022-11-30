import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/season_detail_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SeasonDetailResponse', () {
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

    final tSeasonDetailModel = SeasonDetailResponse(
      episodeList: [tEpisodeModel],
    );

    const tSeasonDetailJson = {
      "_id": "56ed95d3c3a368224e007616",
      "air_date": "2020-02-02",
      "name": "name",
      "overview": "",
      "id": 1,
      "poster_path": "/poster_path.jpg",
      "season_number": 1,
      "episodes": [
        tEpisodeJson,
      ],
    };

    test('fromJson', () {
      expect(
        tSeasonDetailModel,
        SeasonDetailResponse.fromJson(tSeasonDetailJson),
      );
    });

    test('props correct', () {
      expect(
        tSeasonDetailModel.props,
        equals([
          [tEpisodeModel]
        ]),
      );
    });
  });
}
