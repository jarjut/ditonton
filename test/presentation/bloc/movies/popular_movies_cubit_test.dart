import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movies/popular_movies/popular_movies_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  group('PopularMoviesCubit', () {
    late GetPopularMovies getPopularMovies;

    setUp(() {
      getPopularMovies = MockGetPopularMovies();
    });

    PopularMoviesCubit buildCubit() {
      return PopularMoviesCubit(getPopularMovies);
    }

    test('correct initial state ', () {
      expect(buildCubit().state, PopularMoviesInitial());
    });

    blocTest<PopularMoviesCubit, PopularMoviesState>(
      'emits [Loading, Loaded] when fetchPopularMovies success',
      setUp: () {
        when(() => getPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchPopularMovies(),
      expect: () => <PopularMoviesState>[
        PopularMoviesLoading(),
        PopularMoviesLoaded(testMovieList)
      ],
    );

    blocTest<PopularMoviesCubit, PopularMoviesState>(
      'emits [Loading, Error] when fetchPopularMovies failure',
      setUp: () {
        when(() => getPopularMovies.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchPopularMovies(),
      expect: () => <PopularMoviesState>[
        PopularMoviesLoading(),
        const PopularMoviesError('Server Failure')
      ],
    );
  });
}
