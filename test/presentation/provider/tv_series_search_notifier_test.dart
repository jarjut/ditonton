import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchNotifier notifier;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    notifier = TvSeriesSearchNotifier(searchTvSeries: mockSearchTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  group('TvSeriesSearchNotifier', () {
    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockSearchTvSeries.execute(any))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      notifier.fetchTvSeriesSearch('test');
      // assert
      expect(notifier.state, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvSeries.execute(any))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      await notifier.fetchTvSeriesSearch('test');
      // assert
      expect(notifier.searchResult, testTvSeriesList);
      expect(notifier.state, RequestState.loaded);
      expect(listenerCallCount, 2);
    });

    test('should change state to error when data is gotten unsuccessfully',
        () async {
      // arrange
      when(mockSearchTvSeries.execute(any))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchTvSeriesSearch('test');
      // assert
      expect(notifier.state, RequestState.error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
