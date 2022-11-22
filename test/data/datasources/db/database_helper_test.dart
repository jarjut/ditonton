import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  late DatabaseHelper databaseHelper;

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  setUp(() {
    databaseHelper = DatabaseHelper(isTest: true);
  });

  tearDown(() async {
    final db = await databaseHelper.database;
    db?.close();
  });

  group('DatabaseHelper', () {
    group('Movie', () {
      test('Insert Watchlist', () async {
        await databaseHelper.insertWatchlist(testMovieTable);
        final getMovieWatchlist =
            await databaseHelper.getMovieById(testMovieTable.id);
        expect(getMovieWatchlist, testMovieMap);
      });

      test('Remove Watchlist', () async {
        await databaseHelper.insertWatchlist(testMovieTable);
        await databaseHelper.removeWatchlist(testMovieTable);
        final getMovieWatchlist =
            await databaseHelper.getMovieById(testMovieTable.id);
        expect(getMovieWatchlist, null);
      });

      test('Get Watchlist Movies', () async {
        await databaseHelper.insertWatchlist(testMovieTable);
        final getMovieWatchlist = await databaseHelper.getWatchlistMovies();
        expect(getMovieWatchlist, [testMovieMap]);
      });
    });

    group('TvSeries', () {
      test('Insert Watchlist', () async {
        await databaseHelper.insertTvWatchlist(testTvSeriesTable);
        final getMovieWatchlist =
            await databaseHelper.getTvById(testTvSeriesTable.id);
        expect(getMovieWatchlist, testTvSeriesMap);
      });

      test('Remove Watchlist', () async {
        await databaseHelper.insertTvWatchlist(testTvSeriesTable);
        await databaseHelper.removeTvWatchlist(testTvSeriesTable);
        final getMovieWatchlist =
            await databaseHelper.getTvById(testTvSeriesTable.id);
        expect(getMovieWatchlist, null);
      });

      test('Get Watchlist Movies', () async {
        await databaseHelper.insertTvWatchlist(testTvSeriesTable);
        final getMovieWatchlist = await databaseHelper.getWatchlistTv();
        expect(getMovieWatchlist, [testTvSeriesMap]);
      });
    });
  });
}
