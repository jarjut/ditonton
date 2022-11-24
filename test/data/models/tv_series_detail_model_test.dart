import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesDetailModel = TvSeriesDetailModel(
    id: 1,
    adult: false,
    popularity: 2020.20,
    voteAverage: 2,
    genres: const [
      GenreModel(id: 1, name: 'Action'),
      GenreModel(id: 2, name: 'Adventure'),
    ],
    overview: "Overview",
    posterPath: "/posterPath.jpg",
    backdropPath: "/backdropPath.jpg",
    firstAirDate: DateTime(2020, 2, 2),
    originCountry: const ["US"],
    originalLanguage: "en",
    voteCount: 2020,
    name: "Name",
    originalName: "OriginalName",
    episodeRunTime: const [20],
    homepage: "https://www.homepage.com",
    inProduction: true,
    languages: const ['en'],
    lastAirDate: DateTime(2020, 2, 2),
    numberOfEpisodes: 16,
    numberOfSeasons: 2,
    seasons: [
      SeasonModel(
        airDate: DateTime(2021, 10, 12),
        episodeCount: 8,
        id: 126146,
        name: "Season 1",
        overview: "",
        posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
        seasonNumber: 1,
      ),
    ],
    status: "Returning Series",
    tagline: "A classic coming of rage story.",
    type: "Scripted",
  );

  final tTvSeriesDetailJson = {
    "id": 1,
    "adult": false,
    "popularity": 2020.20,
    "vote_average": 2,
    "genres": [
      {"id": 1, "name": "Action"},
      {"id": 2, "name": "Adventure"},
    ],
    "overview": "Overview",
    "poster_path": "/posterPath.jpg",
    "backdrop_path": "/backdropPath.jpg",
    "first_air_date": "2020-02-02",
    "origin_country": ["US"],
    "original_language": "en",
    "vote_count": 2020,
    "name": "Name",
    "original_name": "OriginalName",
    "episode_run_time": [20],
    "homepage": "https://www.homepage.com",
    "in_production": true,
    "languages": ["en"],
    "last_air_date": "2020-02-02",
    "number_of_episodes": 16,
    "number_of_seasons": 2,
    "seasons": [
      {
        "air_date": "2021-10-12",
        "episode_count": 8,
        "id": 126146,
        "name": "Season 1",
        "overview": "",
        "poster_path": "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
        "season_number": 1
      }
    ],
    "last_episode_to_air": null,
    "next_episode_to_air": null,
    "status": "Returning Series",
    "tagline": "A classic coming of rage story.",
    "type": "Scripted"
  };

  group('TvSeriesDetailModel', () {
    test('toJson', () {
      final result = tTvSeriesDetailModel.toJson();
      expect(result, tTvSeriesDetailJson);
    });
  });
}
