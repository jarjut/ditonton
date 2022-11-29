import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTvSeries(mockTvRepository);
  });

  const tQuery = "Hero";

  group('search tv series', () {
    test('should get list of tv series from repository', () async {
      // arrange
      when(() => mockTvRepository.searchTvSeries(tQuery))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      final result = await usecase.execute(tQuery);
      // assert
      expect(result, Right(testTvSeriesList));
    });
  });
}
