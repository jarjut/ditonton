import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieDetailResponse', () {
    const tMovieDetailModel = MovieDetailResponse(
      adult: true,
      backdropPath: 'backdropPath',
      budget: 1,
      genres: [],
      homepage: 'homepage',
      id: 1,
      imdbId: 'imdbId',
      originalLanguage: 'originalLanguage',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 1,
      runtime: 1,
      status: 'status',
      tagline: 'tagline',
      title: 'title',
      video: true,
      voteAverage: 1,
      voteCount: 1,
    );

    const tMovieDetailJson = {
      "adult": true,
      "backdrop_path": "backdropPath",
      "budget": 1,
      "genres": [],
      "homepage": "homepage",
      "id": 1,
      "imdb_id": "imdbId",
      "original_language": "originalLanguage",
      "original_title": "originalTitle",
      "overview": "overview",
      "popularity": 1,
      "poster_path": "posterPath",
      "release_date": "releaseDate",
      "revenue": 1,
      "runtime": 1,
      "status": "status",
      "tagline": "tagline",
      "title": "title",
      "video": true,
      "vote_average": 1,
      "vote_count": 1,
    };

    test('fromJson', () {
      expect(tMovieDetailModel, MovieDetailResponse.fromJson(tMovieDetailJson));
    });

    test('toJson', () {
      expect(tMovieDetailJson, tMovieDetailModel.toJson());
    });
  });
}
