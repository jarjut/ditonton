import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('tv local data source', () {
    group('save watchlist', () {
      test('should return success message when insert to database is success',
          () async {
        // arrange
        when(() => mockDatabaseHelper.insertTvWatchlist(testTvSeriesTable))
            .thenAnswer((_) async => 1);
        // act
        final result = await dataSource.insertWatchlist(testTvSeriesTable);
        // assert
        expect(result, 'Added to Watchlist');
      });

      test('should throw DatabaseException when insert to database is failed',
          () async {
        // arrange
        when(() => mockDatabaseHelper.insertTvWatchlist(testTvSeriesTable))
            .thenThrow(Exception());
        // act
        final call = dataSource.insertWatchlist(testTvSeriesTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      });
    });

    group('remove watchlist', () {
      test('should return success message when remove from database is success',
          () async {
        // arrange
        when(() => mockDatabaseHelper.removeTvWatchlist(testTvSeriesTable))
            .thenAnswer((_) async => 1);
        // act
        final result = await dataSource.removeWatchlist(testTvSeriesTable);
        // assert
        expect(result, 'Removed from Watchlist');
      });

      test('should throw DatabaseException when remove from database is failed',
          () async {
        // arrange
        when(() => mockDatabaseHelper.removeTvWatchlist(testTvSeriesTable))
            .thenThrow(Exception());
        // act
        final call = dataSource.removeWatchlist(testTvSeriesTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      });
    });

    group('Get Tv Detail By Id', () {
      const tId = 1;

      test('should return TvSeriesTable when data is found', () async {
        // arrange
        when(() => mockDatabaseHelper.getTvById(tId))
            .thenAnswer((_) async => testTvSeriesMap);
        // act
        final result = await dataSource.getTvSeriesById(tId);
        // assert
        expect(result, testTvSeriesTable);
      });

      test('should return null when data is not found', () async {
        // arrange
        when(() => mockDatabaseHelper.getTvById(tId))
            .thenAnswer((_) async => null);
        // act
        final result = await dataSource.getTvSeriesById(tId);
        // assert
        expect(result, null);
      });
    });

    group('get watchlist movies', () {
      test('should return list of TvSeriesTable from database', () async {
        // arrange
        when(() => mockDatabaseHelper.getWatchlistTv())
            .thenAnswer((_) async => [testTvSeriesMap]);
        // act
        final result = await dataSource.getWatchlistTvSeries();
        // assert
        expect(result, [testTvSeriesTable]);
      });

      test(
          'should throw DatabaseException when get data from database is failed',
          () async {
        // arrange
        when(() => mockDatabaseHelper.getWatchlistTv()).thenThrow(Exception());
        // act
        final call = dataSource.getWatchlistTvSeries();
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      });
    });
  });
}
