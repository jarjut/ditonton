import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_season_episodes.dart';
import 'package:ditonton/presentation/bloc/tv_series/season_episodes/season_episodes_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetSeasonEpisodes extends Mock implements GetSeasonEpisodes {}

void main() {
  group('SeasonEpisodesCubit', () {
    late GetSeasonEpisodes getSeasonEpisodes;

    setUp(() {
      getSeasonEpisodes = MockGetSeasonEpisodes();
    });

    SeasonEpisodesCubit buildCubit() {
      return SeasonEpisodesCubit(getSeasonEpisodes);
    }

    test('correct initial state', () {
      expect(buildCubit().state, const SeasonEpisodesInitial());
    });

    blocTest<SeasonEpisodesCubit, SeasonEpisodesState>(
      'emits [Loading, Loaded] when fetchSeasonEpisodes success',
      setUp: () {
        when(() => getSeasonEpisodes.execute(1, 1))
            .thenAnswer((_) async => Right(testEpisodeList));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchSeasonEpisodes(1, 1),
      expect: () => <SeasonEpisodesState>[
        const SeasonEpisodesLoading(),
        SeasonEpisodesLoaded(testEpisodeList)
      ],
    );

    blocTest<SeasonEpisodesCubit, SeasonEpisodesState>(
      'emits [Loading, Error] when fetchSeasonEpisodes failure',
      setUp: () {
        when(() => getSeasonEpisodes.execute(1, 1)).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchSeasonEpisodes(1, 1),
      expect: () => <SeasonEpisodesState>[
        const SeasonEpisodesLoading(),
        const SeasonEpisodesError('Server Failure')
      ],
    );
  });
}
