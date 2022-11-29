import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchlistMovies extends Mock implements GetWatchlistMovies {}

void main() {
  group('WatchlistMovieCubit', () {
    late GetWatchlistMovies getWatchlistMovies;

    setUp(() {
      getWatchlistMovies = MockGetWatchlistMovies();
    });

    WatchlistMovieCubit buildCubit() {
      return WatchlistMovieCubit(getWatchlistMovies);
    }

    test('correct initial state', () {
      expect(buildCubit().state, WatchlistMovieInitial());
    });

    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'emits [Loading, Loaded] when fetchWatchlistMovie success',
      setUp: () {
        when(() => getWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchWatchlistMovies(),
      expect: () => <WatchlistMovieState>[
        WatchlistMovieLoading(),
        WatchlistMovieLoaded(testMovieList)
      ],
    );

    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'emits [Loading, Error] when fetchWatchlistMovie failure',
      setUp: () {
        when(() => getWatchlistMovies.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchWatchlistMovies(),
      expect: () => <WatchlistMovieState>[
        WatchlistMovieLoading(),
        const WatchlistMovieError('Server Failure')
      ],
    );
  });
}
