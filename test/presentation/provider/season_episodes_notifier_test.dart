import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/get_season_episodes.dart';
import 'package:ditonton/presentation/provider/season_episodes_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'season_episodes_notifier_test.mocks.dart';

@GenerateMocks([GetSeasonEpisodes])
void main() {
  late MockGetSeasonEpisodes mockGetSeasonEpisodes;
  late SeasonEpisodesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeasonEpisodes = MockGetSeasonEpisodes();
    notifier = SeasonEpisodesNotifier(getSeasonEpisodes: mockGetSeasonEpisodes)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  group('SeasonEpisodesNotifier', () {
    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetSeasonEpisodes.execute(any, any))
          .thenAnswer((_) async => Right(testEpisodeList));
      // act
      notifier.fetchSeasonEpisodes(1, 1);
      // assert
      expect(notifier.episodeListState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change episodes data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetSeasonEpisodes.execute(any, any))
          .thenAnswer((_) async => Right(testEpisodeList));
      // act
      await notifier.fetchSeasonEpisodes(1, 1);
      // assert
      expect(notifier.episodeList, testEpisodeList);
      expect(notifier.episodeListState, RequestState.loaded);
      expect(listenerCallCount, 2);
    });

    test('should change state to error when data is gotten unsuccessfully',
        () async {
      // arrange
      when(mockGetSeasonEpisodes.execute(any, any))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchSeasonEpisodes(1, 1);
      // assert
      expect(notifier.episodeListState, RequestState.error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
