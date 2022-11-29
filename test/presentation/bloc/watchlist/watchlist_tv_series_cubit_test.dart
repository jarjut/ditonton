import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_tv_series/watchlist_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchlistTvSeries extends Mock implements GetWatchlistTvSeries {}

void main() {
  group('WatchlistTvSeriesCubit', () {
    late GetWatchlistTvSeries getWatchlistTvSeries;

    setUp(() {
      getWatchlistTvSeries = MockGetWatchlistTvSeries();
    });

    WatchlistTvSeriesCubit buildCubit() {
      return WatchlistTvSeriesCubit(getWatchlistTvSeries);
    }

    test('correct initial state', () {
      expect(buildCubit().state, WatchlistTvSeriesInitial());
    });

    blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
      'emits [Loading, Loaded] when fetchWatchlistTvSeries success',
      setUp: () {
        when(() => getWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchWatchlistTvSeries(),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesLoaded(testTvSeriesList)
      ],
    );

    blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
      'emits [Loading, Error] when fetchWatchlistTvSeries failure',
      setUp: () {
        when(() => getWatchlistTvSeries.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchWatchlistTvSeries(),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesLoading(),
        const WatchlistTvSeriesError('Server Failure')
      ],
    );
  });
}
