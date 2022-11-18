import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopRatedTvSeries(mockTvRepository);
  });

  group('get top rated tv series usecase', () {
    test('should get list of tv series from repository', () async {
      // arrange
      when(mockTvRepository.getTopRatedTvSeries())
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(testTvSeriesList));
    });
  });
}
