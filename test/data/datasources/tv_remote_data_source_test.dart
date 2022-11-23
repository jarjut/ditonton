import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/season_detail_response.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const kApiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const kBaseUrl = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('tv remote data source', () {
    group('get Now Playing Tv Series', () {
      final tTvList = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/now_playing_tv.json')),
      ).tvList;

      test('should return list of TvSeries Model when the response code is 200',
          () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$kBaseUrl/tv/on_the_air?$kApiKey')),
        ).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/now_playing_tv.json'), 200),
        );
        // act
        final result = await dataSource.getNowPlayingTvSeries();
        // assert
        expect(result, equals(tTvList));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$kBaseUrl/tv/on_the_air?$kApiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getNowPlayingTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });

    group('get Popular Tv Series', () {
      final tTvList = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/popular_tv.json')),
      ).tvList;

      test('should return list of tv series when response is success (200)',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$kBaseUrl/tv/popular?$kApiKey')))
            .thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/popular_tv.json'), 200),
        );
        // act
        final result = await dataSource.getPopularTvSeries();
        // assert
        expect(result, tTvList);
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$kBaseUrl/tv/popular?$kApiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getPopularTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });

    group('get Top Rated tv series', () {
      final tTvList = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/top_rated_tv.json')),
      ).tvList;

      test('should return list of tv series when response code is 200 ',
          () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$kBaseUrl/tv/top_rated?$kApiKey')),
        ).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/top_rated_tv.json'), 200),
        );
        // act
        final result = await dataSource.getTopRatedTvSeries();
        // assert
        expect(result, tTvList);
      });

      test('should throw ServerException when response code is other than 200',
          () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$kBaseUrl/tv/top_rated?$kApiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTopRatedTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });

    group('get movie detail', () {
      const tId = 1;
      final tTvDetail = TvSeriesDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')),
      );

      test('should return movie detail when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$kBaseUrl/tv/$tId?$kApiKey')))
            .thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/tv_detail.json'), 200),
        );
        // act
        final result = await dataSource.getTvDetail(tId);
        // assert
        expect(result, equals(tTvDetail));
      });

      test(
          'should throw Server Exception when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$kBaseUrl/tv/$tId?$kApiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvDetail(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });

    group('get movie recommendations', () {
      final tTvList = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/tv_recommendations.json')),
      ).tvList;

      const tId = 1;

      test('should return list of Movie Model when the response code is 200',
          () async {
        // arrange
        when(
          mockHttpClient
              .get(Uri.parse('$kBaseUrl/tv/$tId/recommendations?$kApiKey')),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_recommendations.json'),
            200,
          ),
        );
        // act
        final result = await dataSource.getTvRecommendations(tId);
        // assert
        expect(result, equals(tTvList));
      });

      test(
          'should throw Server Exception when the response code is 404 or other',
          () async {
        // arrange
        when(
          mockHttpClient
              .get(Uri.parse('$kBaseUrl/tv/$tId/recommendations?$kApiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvRecommendations(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });

    group('search tv series', () {
      final tTvSearchResult = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/search_hero_tv.json')),
      ).tvList;

      const tQuery = 'Hero';

      test('should return list of tv series when response code is 200',
          () async {
        // arrange
        when(
          mockHttpClient
              .get(Uri.parse('$kBaseUrl/search/tv?$kApiKey&query=$tQuery')),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/search_hero_tv.json'),
            200,
          ),
        );
        // act
        final result = await dataSource.searchTvSeries(tQuery);
        // assert
        expect(result, tTvSearchResult);
      });

      test('should throw ServerException when response code is other than 200',
          () async {
        // arrange
        when(
          mockHttpClient
              .get(Uri.parse('$kBaseUrl/search/tv?$kApiKey&query=$tQuery')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.searchTvSeries(tQuery);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });

    group('get Season Episodes', () {
      final tSeasonEpisodes = SeasonDetailResponse.fromJson(
        json.decode(readJson('dummy_data/detail_season.json')),
      ).episodeList;

      const tId = 1;
      const tSeasonNumber = 1;

      test('should return list of episodes when response code is 200',
          () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse('$kBaseUrl/tv/$tId/season/$tSeasonNumber?$kApiKey'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/detail_season.json'),
            200,
          ),
        );
        // act
        final result = await dataSource.getSeasonEpisodes(tId, tSeasonNumber);
        // assert
        expect(result, tSeasonEpisodes);
      });

      test('should throw ServerException when response code is other than 200',
          () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse('$kBaseUrl/tv/$tId/season/$tSeasonNumber?$kApiKey'),
          ),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getSeasonEpisodes(tId, tSeasonNumber);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });
  });
}
