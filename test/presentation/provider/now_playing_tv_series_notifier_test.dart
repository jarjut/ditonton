import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/provider/now_playing_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late NowPlayingTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    notifier = NowPlayingTvSeriesNotifier(mockGetNowPlayingTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  group('NowPlayingTvSeriesNotifier', () {
    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      notifier.fetchNowPlayingTvSeries();
      // assert
      expect(notifier.state, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      await notifier.fetchNowPlayingTvSeries();
      // assert
      expect(notifier.tvSeries, testTvSeriesList);
      expect(notifier.state, RequestState.loaded);
      expect(listenerCallCount, 2);
    });

    test('should change state to error when data is gotten unsuccessfully',
        () async {
      // arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchNowPlayingTvSeries();
      // assert
      expect(notifier.state, RequestState.error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
