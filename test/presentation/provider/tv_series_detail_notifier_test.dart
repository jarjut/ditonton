import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvSeriesDetailNotifier notifier;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    notifier = TvSeriesDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatusTv: mockGetWatchListStatusTv,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  group('GetTvSeriesDetailNotifier', () {
    const tId = 1;

    arrangeNormalCase() {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesList));
    }

    test('should get data from the usecase', () async {
      // arrange
      arrangeNormalCase();
      // act
      await notifier.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetTvRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      arrangeNormalCase();
      // act
      notifier.fetchTvSeriesDetail(tId);
      // assert
      expect(notifier.tvSeriesState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      arrangeNormalCase();
      // act
      await notifier.fetchTvSeriesDetail(tId);
      // assert
      expect(notifier.tvSeriesState, RequestState.loaded);
      expect(notifier.tvSeries, testTvSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tv seriess when data is gotten successfully',
        () async {
      // arrange
      arrangeNormalCase();
      // act
      await notifier.fetchTvSeriesDetail(tId);
      // assert
      expect(notifier.tvSeriesState, RequestState.loaded);
      expect(notifier.tvSeriesRecommendations, testTvSeriesList);
    });

    test('should return error message when failed to get tv series detail',
        () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failure')));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failure')));
      // act
      await notifier.fetchTvSeriesDetail(tId);

      // assert
      expect(notifier.tvSeriesState, RequestState.error);
      expect(notifier.message, 'Failure');
    });

    test(
        'should return error message when failed to get tv series recommendation',
        () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failure')));
      // act
      await notifier.fetchTvSeriesDetail(tId);

      // assert
      expect(notifier.tvSeriesState, RequestState.loaded);
      expect(notifier.recommendationState, RequestState.error);
      expect(notifier.message, 'Failure');
    });

    test('should get watchlist status', () async {
      // arrange
      when(mockGetWatchListStatusTv.execute(tId)).thenAnswer((_) async => true);
      // act
      await notifier.loadWatchlistStatus(tId);
      // assert
      expect(notifier.isAddedToWatchlist, true);
    });

    test('should execute save watchlist', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchListStatusTv.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await notifier.addWatchlist(testTvSeriesDetail);
      // assert
      verify(mockSaveWatchlistTv.execute(testTvSeriesDetail));
      expect(notifier.watchlistMessage, 'Success');
      expect(notifier.isAddedToWatchlist, true);
    });

    test('should return error message when save watchlist error', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failure')));
      when(mockGetWatchListStatusTv.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await notifier.addWatchlist(testTvSeriesDetail);
      // assert
      verify(mockSaveWatchlistTv.execute(testTvSeriesDetail));
      expect(notifier.watchlistMessage, 'Failure');
    });

    test('should execute remove watchlist', () async {
      // arrange
      when(mockRemoveWatchlistTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchListStatusTv.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await notifier.removeFromWatchlist(testTvSeriesDetail);
      // assert
      verify(mockRemoveWatchlistTv.execute(testTvSeriesDetail));
      expect(notifier.watchlistMessage, 'Success');
      expect(notifier.isAddedToWatchlist, false);
    });

    test('should return error message when remove watchlist error', () async {
      // arrange
      when(mockRemoveWatchlistTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failure')));
      when(mockGetWatchListStatusTv.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await notifier.removeFromWatchlist(testTvSeriesDetail);
      // assert
      verify(mockRemoveWatchlistTv.execute(testTvSeriesDetail));
      expect(notifier.watchlistMessage, 'Failure');
    });
  });
}
