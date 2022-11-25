import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/get_season_episodes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonEpisodes usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetSeasonEpisodes(mockTvRepository);
  });

  group('get season episodes usecase', () {
    const int tTvId = 1;
    const int tSeasonNumber = 1;
    test('should get list of episodes from repository', () async {
      // arrange
      when(mockTvRepository.getSeasonEpisodes(tTvId, tSeasonNumber))
          .thenAnswer((_) async => Right(testEpisodeList));
      // act
      final result = await usecase.execute(tTvId, tSeasonNumber);
      // assert
      expect(result, Right(testEpisodeList));
    });
  });
}
