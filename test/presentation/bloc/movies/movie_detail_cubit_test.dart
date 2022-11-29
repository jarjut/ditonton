import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movies/movie_detail/movie_detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}

class MockSaveWatchlist extends Mock implements SaveWatchlist {}

class MockRemoveWatchlist extends Mock implements RemoveWatchlist {}

void main() {
  group('MovieDetailCubit', () {
    late GetMovieDetail getMovieDetail;
    late GetWatchListStatus getWatchListStatus;
    late SaveWatchlist saveWatchlist;
    late RemoveWatchlist removeWatchlist;

    setUp(() {
      getMovieDetail = MockGetMovieDetail();
      getWatchListStatus = MockGetWatchListStatus();
      saveWatchlist = MockSaveWatchlist();
      removeWatchlist = MockRemoveWatchlist();
    });

    MovieDetailCubit getMovieDetailCubit() {
      return MovieDetailCubit(
        getMovieDetail: getMovieDetail,
        getWatchListStatus: getWatchListStatus,
        saveWatchlist: saveWatchlist,
        removeWatchlist: removeWatchlist,
      );
    }

    test('initial RequestState is empty', () {
      expect(getMovieDetailCubit().state.state, RequestState.empty);
    });

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should load movieDetail when fetchMovieDetail is called',
      setUp: () {
        when(() => getMovieDetail.execute(1))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(() => getWatchListStatus.execute(1)).thenAnswer((_) async => true);
      },
      build: () => getMovieDetailCubit(),
      act: (cubit) => cubit.fetchMovieDetail(1),
      expect: () => const <MovieDetailState>[
        MovieDetailState(state: RequestState.loading),
        MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
        ),
        MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should load error message when fetchMovieDetail is failed',
      setUp: () {
        when(() => getMovieDetail.execute(1))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        when(() => getWatchListStatus.execute(1)).thenAnswer((_) async => true);
      },
      build: () => getMovieDetailCubit(),
      act: (cubit) => cubit.fetchMovieDetail(1),
      expect: () => const <MovieDetailState>[
        MovieDetailState(state: RequestState.loading),
        MovieDetailState(
          state: RequestState.error,
          errorMessage: 'Failed',
        ),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should change watchlist status when addWatchlist is called',
      setUp: () {
        when(() => saveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(() => getWatchListStatus.execute(1)).thenAnswer((_) async => true);
      },
      seed: () => const MovieDetailState(
        state: RequestState.loaded,
        movieDetail: testMovieDetail,
        isAddedToWatchlist: false,
      ),
      build: () => getMovieDetailCubit(),
      act: (cubit) => cubit.addWatchlist(testMovieDetail),
      expect: () => const <MovieDetailState>[
        MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          watchlistMessage: 'Success',
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          watchlistMessage: 'Success',
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should load watchlist error message when addWatchlist is failed',
      setUp: () {
        when(() => saveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      },
      seed: () => const MovieDetailState(
        state: RequestState.loaded,
        movieDetail: testMovieDetail,
        isAddedToWatchlist: false,
      ),
      build: () => getMovieDetailCubit(),
      act: (cubit) => cubit.addWatchlist(testMovieDetail),
      expect: () => const <MovieDetailState>[
        MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          watchlistMessage: 'Failed',
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should change watchlist status when removeWatchlist is called',
      setUp: () {
        when(() => removeWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(() => getWatchListStatus.execute(1))
            .thenAnswer((_) async => false);
      },
      seed: () => const MovieDetailState(
        state: RequestState.loaded,
        movieDetail: testMovieDetail,
        isAddedToWatchlist: true,
      ),
      build: () => getMovieDetailCubit(),
      act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
      expect: () => const <MovieDetailState>[
        MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          watchlistMessage: 'Success',
          isAddedToWatchlist: true,
        ),
        MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          watchlistMessage: 'Success',
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should load watchlist error message when removeWatchlist is failed',
      setUp: () {
        when(() => removeWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      },
      seed: () => const MovieDetailState(
        state: RequestState.loaded,
        movieDetail: testMovieDetail,
        isAddedToWatchlist: true,
      ),
      build: () => getMovieDetailCubit(),
      act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
      expect: () => const <MovieDetailState>[
        MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          watchlistMessage: 'Failed',
          isAddedToWatchlist: true,
        ),
      ],
    );
  });
}
