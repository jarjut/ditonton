import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movies/movie_recommendation/movie_recommendation_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetMovieRecommendations extends Mock
    implements GetMovieRecommendations {}

void main() {
  group('MovieRecommendationCubit', () {
    late GetMovieRecommendations getMovieRecommendations;

    setUp(() {
      getMovieRecommendations = MockGetMovieRecommendations();
    });

    MovieRecommendationCubit buildCubit() {
      return MovieRecommendationCubit(
        getMovieRecommendations: getMovieRecommendations,
      );
    }

    test('correct initial state', () {
      expect(buildCubit().state, const MovieRecommendationInitial());
    });

    blocTest<MovieRecommendationCubit, MovieRecommendationState>(
      'should load movieRecommendations when fetchMovieRecommendations is called',
      setUp: () {
        when(() => getMovieRecommendations.execute(1))
            .thenAnswer((_) async => Right(testMovieList));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchMovieRecommendations(1),
      expect: () => <MovieRecommendationState>[
        const MovieRecommendationLoading(),
        MovieRecommendationLoaded(testMovieList),
      ],
    );

    blocTest<MovieRecommendationCubit, MovieRecommendationState>(
      'should load error message when fetchMovieRecommendations is failed',
      setUp: () {
        when(() => getMovieRecommendations.execute(1))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchMovieRecommendations(1),
      expect: () => <MovieRecommendationState>[
        const MovieRecommendationLoading(),
        const MovieRecommendationError('Failed'),
      ],
    );
  });
}
