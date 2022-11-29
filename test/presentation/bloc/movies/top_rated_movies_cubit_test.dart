import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movies/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  group('TopRatedMoviesCubit', () {
    late GetTopRatedMovies getTopRatedMovies;

    setUp(() {
      getTopRatedMovies = MockGetTopRatedMovies();
    });

    TopRatedMoviesCubit buildCubit() {
      return TopRatedMoviesCubit(getTopRatedMovies);
    }

    test('correct initial state ', () {
      expect(buildCubit().state, TopRatedMoviesInitial());
    });

    blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
      'emits [Loading, Loaded] when fetchTopRatedMovies success',
      setUp: () {
        when(() => getTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchTopRatedMovies(),
      expect: () => <TopRatedMoviesState>[
        TopRatedMoviesLoading(),
        TopRatedMoviesLoaded(testMovieList)
      ],
    );

    blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
      'emits [Loading, Error] when fetchTopRatedMovies failure',
      setUp: () {
        when(() => getTopRatedMovies.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchTopRatedMovies(),
      expect: () => <TopRatedMoviesState>[
        TopRatedMoviesLoading(),
        const TopRatedMoviesError('Server Failure')
      ],
    );
  });
}
