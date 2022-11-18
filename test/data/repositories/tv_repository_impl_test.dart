import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('TV Repository', () {
    group('Now Playing', () {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTvSeries()).thenAnswer(
          (_) async => testTvSeriesModelList,
        );
        // act
        final result = await repository.getNowPlayingTvSeries();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTvSeries());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(
          resultList,
          testTvSeriesList,
        );
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTvSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getNowPlayingTvSeries();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTvSeries());
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return connection failure when the device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTvSeries()).thenThrow(
          const SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.getNowPlayingTvSeries();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTvSeries());
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      });
    });

    group('Popular Tv Series', () {
      test('should return Tv Series list when call to data source is success',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvSeries())
            .thenAnswer((_) async => testTvSeriesModelList);
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, testTvSeriesList);
      });

      test(
          'should return server failure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        expect(result, const Left(ServerFailure('')));
      });

      test(
          'should return connection failure when device is not connected to the internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvSeries()).thenThrow(
          const SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      });
    });

    group('Top Rated Tv Series', () {
      test(
          'should return Tv Series list when call to data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvSeries())
            .thenAnswer((_) async => testTvSeriesModelList);
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, testTvSeriesList);
      });

      test(
          'should return ServerFailure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        expect(result, const Left(ServerFailure('')));
      });

      test(
          'should return ConnectionFailure when device is not connected to the internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvSeries()).thenThrow(
          const SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      });
    });

    group('Get Tv Series Detail', () {
      const tId = 1;

      test(
          'should return Tv Series data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(tId))
            .thenAnswer((_) async => testTvSeriedDetailModel);
        // act
        final result = await repository.getTvSeriesDetail(tId);
        // assert
        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(result, equals(Right(testTvSeriedDetail)));
      });

      test(
          'should return Server Failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(tId))
            .thenThrow(ServerException());
        // act
        final result = await repository.getTvSeriesDetail(tId);
        // assert
        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return connection failure when the device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(
          const SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.getTvSeriesDetail(tId);
        // assert
        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      });
    });

    group('Get Tv Series Recommendations', () {
      const tId = 1;

      test('should return data (Tv Series list) when the call is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvRecommendations(tId))
            .thenAnswer((_) async => testTvSeriesModelList);
        // act
        final result = await repository.getTvRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getTvRecommendations(tId));
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(testTvSeriesList));
      });

      test(
          'should return server failure when call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvRecommendations(tId))
            .thenThrow(ServerException());
        // act
        final result = await repository.getTvRecommendations(tId);
        // assertbuild runner
        verify(mockRemoteDataSource.getTvRecommendations(tId));
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return connection failure when the device is not connected to the internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvRecommendations(tId)).thenThrow(
          const SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.getTvRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getTvRecommendations(tId));
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      });
    });

    group('Seach Tv Series', () {
      const tQuery = 'hero';

      test(
          'should return Tv Series list when call to data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.searchTvSeries(tQuery))
            .thenAnswer((_) async => testTvSeriesModelList);
        // act
        final result = await repository.searchTvSeries(tQuery);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, testTvSeriesList);
      });

      test(
          'should return ServerFailure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.searchTvSeries(tQuery))
            .thenThrow(ServerException());
        // act
        final result = await repository.searchTvSeries(tQuery);
        // assert
        expect(result, const Left(ServerFailure('')));
      });

      test(
          'should return ConnectionFailure when device is not connected to the internet',
          () async {
        // arrange
        when(mockRemoteDataSource.searchTvSeries(tQuery)).thenThrow(
          const SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.searchTvSeries(tQuery);
        // assert
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      });
    });

    group('save watchlist', () {
      test('should return success message when saving successful', () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
            .thenAnswer((_) async => 'Added to Watchlist');
        // act
        final result = await repository.saveWatchlist(testTvSeriedDetail);
        // assert
        expect(result, const Right('Added to Watchlist'));
      });

      test('should return DatabaseFailure when saving unsuccessful', () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
            .thenThrow(DatabaseException('Failed to add watchlist'));
        // act
        final result = await repository.saveWatchlist(testTvSeriedDetail);
        // assert
        expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
      });
    });

    group('remove watchlist', () {
      test('should return success message when remove successful', () async {
        // arrange
        when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
            .thenAnswer((_) async => 'Removed from watchlist');
        // act
        final result = await repository.removeWatchlist(testTvSeriedDetail);
        // assert
        expect(result, const Right('Removed from watchlist'));
      });

      test('should return DatabaseFailure when remove unsuccessful', () async {
        // arrange
        when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
            .thenThrow(DatabaseException('Failed to remove watchlist'));
        // act
        final result = await repository.removeWatchlist(testTvSeriedDetail);
        // assert
        expect(
          result,
          const Left(DatabaseFailure('Failed to remove watchlist')),
        );
      });
    });

    group('get watchlist status', () {
      test('should return watch status whether data is found', () async {
        // arrange
        const tId = 1;
        when(mockLocalDataSource.getTvSeriesById(tId))
            .thenAnswer((_) async => null);
        // act
        final result = await repository.isAddedToWatchlist(tId);
        // assert
        expect(result, false);
      });
    });

    group('get watchlist Tv Series', () {
      test('should return list of Tv Series', () async {
        // arrange
        when(mockLocalDataSource.getWatchlistTvSeries())
            .thenAnswer((_) async => [testTvSeriesTable]);
        // act
        final result = await repository.getWatchlistTvSeries();
        // assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testWatchlistTvSeries]);
      });

      test('should return DatabaseFailure when getting data is unsuccessful',
          () async {
        // arrange
        when(mockLocalDataSource.getWatchlistTvSeries())
            .thenThrow(DatabaseException('Failed to get watchlist'));
        // act
        final result = await repository.getWatchlistTvSeries();
        // assert
        expect(
          result,
          const Left(DatabaseFailure('Failed to get watchlist')),
        );
      });
    });
  });
}
