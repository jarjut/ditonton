import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  const tTvSeriesId = 1;

  group('get tv detail usecase', () {
    test('should get list of tv series from repository', () async {
      // arrange
      when(() => mockTvRepository.getTvSeriesDetail(tTvSeriesId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      // act
      final result = await usecase.execute(tTvSeriesId);
      // assert
      expect(result, Right(testTvSeriesDetail));
    });
  });
}
