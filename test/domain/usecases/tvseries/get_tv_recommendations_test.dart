import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTvRepository);
  });

  const tTvSeriesId = 1;

  group('get tv detail usecase', () {
    test('should get list of tv series from repository', () async {
      // arrange
      when(mockTvRepository.getTvRecommendations(tTvSeriesId))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      final result = await usecase.execute(tTvSeriesId);
      // assert
      expect(result, Right(testTvSeriesList));
    });
  });
}
