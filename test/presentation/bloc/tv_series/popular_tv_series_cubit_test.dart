import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series/popular_tv_series/popular_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetPopularTvSeries extends Mock implements GetPopularTvSeries {}

void main() {
  group('PopularTvSeriesCubit', () {
    late GetPopularTvSeries getPopularTvSeries;

    setUp(() {
      getPopularTvSeries = MockGetPopularTvSeries();
    });

    PopularTvSeriesCubit buildCubit() {
      return PopularTvSeriesCubit(getPopularTvSeries);
    }

    test('correct initial state', () {
      expect(buildCubit().state, PopularTvSeriesInitial());
    });

    blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
      'emits [Loading, Loaded] when fetchPopularTvSeries success',
      setUp: () {
        when(() => getPopularTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchPopularTvSeries(),
      expect: () => <PopularTvSeriesState>[
        PopularTvSeriesLoading(),
        PopularTvSeriesLoaded(testTvSeriesList)
      ],
    );

    blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
      'emits [Loading, Error] when fetchPopularTvSeries failure',
      setUp: () {
        when(() => getPopularTvSeries.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchPopularTvSeries(),
      expect: () => <PopularTvSeriesState>[
        PopularTvSeriesLoading(),
        const PopularTvSeriesError('Server Failure')
      ],
    );
  });
}
