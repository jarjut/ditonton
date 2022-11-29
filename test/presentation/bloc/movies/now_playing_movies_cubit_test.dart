import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movies/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetNowPlayingMovies extends Mock implements GetNowPlayingMovies {}

void main() {
  group('NowPlayingMoviesCubit', () {
    late GetNowPlayingMovies getNowPlayingMovies;

    setUp(() {
      getNowPlayingMovies = MockGetNowPlayingMovies();
    });

    NowPlayingMoviesCubit buildCubit() {
      return NowPlayingMoviesCubit(getNowPlayingMovies);
    }

    test('correct initial state ', () {
      expect(buildCubit().state, NowPlayingMoviesInitial());
    });

    blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
      'emits [Loading, Loaded] when fetchNowPlayingMovies success',
      setUp: () {
        when(() => getNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchNowPlayingMovies(),
      expect: () => <NowPlayingMoviesState>[
        NowPlayingMoviesLoading(),
        NowPlayingMoviesLoaded(testMovieList)
      ],
    );

    blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
      'emits [Loading, Error] when fetchNowPlayingMovies failure',
      setUp: () {
        when(() => getNowPlayingMovies.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchNowPlayingMovies(),
      expect: () => <NowPlayingMoviesState>[
        NowPlayingMoviesLoading(),
        const NowPlayingMoviesError('Server Failure')
      ],
    );
  });
}
