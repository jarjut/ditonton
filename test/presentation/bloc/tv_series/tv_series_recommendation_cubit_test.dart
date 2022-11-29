import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_recommendation/tv_series_recommendation_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTvRecommendations extends Mock implements GetTvRecommendations {}

void main() {
  group('TvSeriesRecommendationCubit', () {
    late GetTvRecommendations getTvRecommendations;

    setUp(() {
      getTvRecommendations = MockGetTvRecommendations();
    });

    TvSeriesRecommendationCubit buildCubit() {
      return TvSeriesRecommendationCubit(getTvRecommendations);
    }

    test('correct initial state', () {
      expect(buildCubit().state, const TvSeriesRecommendationInitial());
    });

    blocTest<TvSeriesRecommendationCubit, TvSeriesRecommendationState>(
      'emits [Loading, Loaded] when fetchTvSeriesRecommendation success',
      setUp: () {
        when(() => getTvRecommendations.execute(1))
            .thenAnswer((_) async => Right(testTvSeriesList));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchTvSeriesRecommendation(1),
      expect: () => <TvSeriesRecommendationState>[
        const TvSeriesRecommendationLoading(),
        TvSeriesRecommendationLoaded(testTvSeriesList)
      ],
    );

    blocTest<TvSeriesRecommendationCubit, TvSeriesRecommendationState>(
      'emits [Loading, Error] when fetchTvSeriesRecommendation failure',
      setUp: () {
        when(() => getTvRecommendations.execute(1)).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchTvSeriesRecommendation(1),
      expect: () => <TvSeriesRecommendationState>[
        const TvSeriesRecommendationLoading(),
        const TvSeriesRecommendationError('Server Failure')
      ],
    );
  });
}
