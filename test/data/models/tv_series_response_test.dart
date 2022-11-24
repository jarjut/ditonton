import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    id: 90462,
    popularity: 3293.494,
    voteAverage: 7.9,
    overview: "Overview",
    firstAirDate: "2021-10-12",
    originCountry: ["US"],
    genreIds: [80, 10765],
    originalLanguage: "en",
    voteCount: 3476,
    name: "Chucky",
    originalName: "Chucky",
    backdropPath: "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
    posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
  );
  const tvTvSeriesResponse = TvSeriesResponse(tvList: [tTvSeriesModel]);

  group('TvSeriesResponse', () {
    test('fromJson', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tvTvSeriesResponse);
    });

    test('toJson', () {
      final result = tvTvSeriesResponse.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
            "first_air_date": "2021-10-12",
            "genre_ids": [80, 10765],
            "id": 90462,
            "name": "Chucky",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Chucky",
            "overview": "Overview",
            "popularity": 3293.494,
            "poster_path": "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
            "vote_average": 7.9,
            "vote_count": 3476
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
