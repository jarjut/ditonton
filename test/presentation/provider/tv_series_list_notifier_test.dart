import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_series_notifier_test.mocks.dart';
import 'popular_tv_series_notifier_test.mocks.dart';
import 'top_rated_tv_series_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
])
void main() {
  late TvSeriesListNotifier notifier;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    notifier = TvSeriesListNotifier(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  group('TVSeriesListNotifier', () {
    group('Now Playing Tv Series', () {
      test('should change state to loading when usecase is called', () async {
        // arrange
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        // act
        notifier.fetchNowPlayingTvSeries();
        // assert
        expect(notifier.nowPlayingState, RequestState.loading);
        expect(listenerCallCount, 1);
      });
      test('should get data from the usecase', () async {
        // arrange
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        // act
        await notifier.fetchNowPlayingTvSeries();
        // assert
        verify(mockGetNowPlayingTvSeries.execute());
        expect(notifier.nowPlayingState, RequestState.loaded);
        expect(notifier.nowPlayingTvSeries, testTvSeriesList);
      });
      test('should return error message if failed', () async {
        // arrange
        when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        // act
        await notifier.fetchNowPlayingTvSeries();
        // assert
        verify(mockGetNowPlayingTvSeries.execute());
        expect(notifier.nowPlayingState, RequestState.error);
        expect(notifier.message, 'Server Failure');
      });
    });

    group('Popular Tv Series', () {
      test('should change state to loading when usecase is called', () async {
        // arrange
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        // act
        notifier.fetchPopularTvSeries();
        // assert
        expect(notifier.popularState, RequestState.loading);
        expect(listenerCallCount, 1);
      });
      test('should get data from the usecase', () async {
        // arrange
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        // act
        await notifier.fetchPopularTvSeries();
        // assert
        verify(mockGetPopularTvSeries.execute());
        expect(notifier.popularState, RequestState.loaded);
        expect(notifier.popularTvSeries, testTvSeriesList);
      });
      test('should return error message if failed', () async {
        // arrange
        when(mockGetPopularTvSeries.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        // act
        await notifier.fetchPopularTvSeries();
        // assert
        verify(mockGetPopularTvSeries.execute());
        expect(notifier.popularState, RequestState.error);
        expect(notifier.message, 'Server Failure');
      });
    });

    group('Top Rated Tv Series', () {
      test('should change state to loading when usecase is called', () async {
        // arrange
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        // act
        notifier.fetchTopRatedTvSeries();
        // assert
        expect(notifier.topRatedState, RequestState.loading);
        expect(listenerCallCount, 1);
      });
      test('should get data from the usecase', () async {
        // arrange
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        // act
        await notifier.fetchTopRatedTvSeries();
        // assert
        verify(mockGetTopRatedTvSeries.execute());
        expect(notifier.topRatedState, RequestState.loaded);
        expect(notifier.topRatedTvSeries, testTvSeriesList);
      });
      test('should return error message if failed', () async {
        // arrange
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        // act
        await notifier.fetchTopRatedTvSeries();
        // assert
        verify(mockGetTopRatedTvSeries.execute());
        expect(notifier.topRatedState, RequestState.error);
        expect(notifier.message, 'Server Failure');
      });
    });
  });
}
