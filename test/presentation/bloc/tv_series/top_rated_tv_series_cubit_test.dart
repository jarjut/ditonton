import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTopRatedTvSeries extends Mock implements GetTopRatedTvSeries {}

void main() {
  group('TopRatedTvSeriesCubit', () {
    late GetTopRatedTvSeries getTopRatedTvSeries;

    setUp(() {
      getTopRatedTvSeries = MockGetTopRatedTvSeries();
    });

    TopRatedTvSeriesCubit buildCubit() {
      return TopRatedTvSeriesCubit(getTopRatedTvSeries);
    }

    test('correct initial state', () {
      expect(buildCubit().state, TopRatedTvSeriesInitial());
    });

    blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
      'emits [Loading, Loaded] when fetchTopRatedTvSeries success',
      setUp: () {
        when(() => getTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchTopRatedTvSeries(),
      expect: () => <TopRatedTvSeriesState>[
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesLoaded(testTvSeriesList)
      ],
    );

    blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
      'emits [Loading, Error] when fetchTopRatedTvSeries failure',
      setUp: () {
        when(() => getTopRatedTvSeries.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchTopRatedTvSeries(),
      expect: () => <TopRatedTvSeriesState>[
        TopRatedTvSeriesLoading(),
        const TopRatedTvSeriesError('Server Failure')
      ],
    );
  });
}
