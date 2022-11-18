import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTvSeries(mockTvRepository);
  });

  group('get popular tv series usecase', () {
    test('should get list of tv series from repository', () async {
      // arrange
      when(mockTvRepository.getPopularTvSeries())
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(testTvSeriesList));
    });
  });
}
