import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series/now_playing_tv_series/now_playing_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetNowPlayingTvSeries extends Mock implements GetNowPlayingTvSeries {}

void main() {
  group('NowPlayingTvSeriesCubit', () {
    late GetNowPlayingTvSeries getNowPlayingTvSeries;

    setUp(() {
      getNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    });

    NowPlayingTvSeriesCubit buildCubit() {
      return NowPlayingTvSeriesCubit(getNowPlayingTvSeries);
    }

    test('correct initial state', () {
      expect(buildCubit().state, NowPlayingTvSeriesInitial());
    });

    blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
      'emits [Loading, Loaded] when fetchNowPlayingTvSeries success',
      setUp: () {
        when(() => getNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchNowPlayingTvSeries(),
      expect: () => <NowPlayingTvSeriesState>[
        NowPlayingTvSeriesLoading(),
        NowPlayingTvSeriesLoaded(testTvSeriesList)
      ],
    );

    blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
      'emits [Loading, Error] when fetchNowPlayingTvSeries failure',
      setUp: () {
        when(() => getNowPlayingTvSeries.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchNowPlayingTvSeries(),
      expect: () => <NowPlayingTvSeriesState>[
        NowPlayingTvSeriesLoading(),
        const NowPlayingTvSeriesError('Server Failure')
      ],
    );
  });
}
