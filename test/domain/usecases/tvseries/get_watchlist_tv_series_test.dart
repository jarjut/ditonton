import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistTvSeries(mockTvRepository);
  });

  group('get watchlist tv series usecase', () {
    test('should get list of tv series from the repository', () async {
      // arrange
      when(() => mockTvRepository.getWatchlistTvSeries())
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(testTvSeriesList));
    });
  });
}
