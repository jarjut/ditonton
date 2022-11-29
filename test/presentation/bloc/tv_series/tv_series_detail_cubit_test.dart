import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_detail/tv_series_detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTvDetail extends Mock implements GetTvDetail {}

class MockGetWatchListStatusTv extends Mock implements GetWatchListStatusTv {}

class MockSaveWatchlistTv extends Mock implements SaveWatchlistTv {}

class MockRemoveWatchlistTv extends Mock implements RemoveWatchlistTv {}

void main() {
  group('TvSeriesDetailCubit', () {
    late GetTvDetail getTvDetail;
    late GetWatchListStatusTv getWatchListStatusTv;
    late SaveWatchlistTv saveWatchlistTv;
    late RemoveWatchlistTv removeWatchlistTv;

    setUp(() {
      getTvDetail = MockGetTvDetail();
      getWatchListStatusTv = MockGetWatchListStatusTv();
      saveWatchlistTv = MockSaveWatchlistTv();
      removeWatchlistTv = MockRemoveWatchlistTv();
    });

    TvSeriesDetailCubit buildCubit() {
      return TvSeriesDetailCubit(
        getTvDetail: getTvDetail,
        getWatchListStatusTv: getWatchListStatusTv,
        saveWatchlistTv: saveWatchlistTv,
        removeWatchlistTv: removeWatchlistTv,
      );
    }

    test('correct initial state', () {
      expect(buildCubit().state, const TvSeriesDetailState());
    });

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should load tvSeriesDetail when fetchTvSeriesDetail is called',
      setUp: () {
        when(() => getTvDetail.execute(1))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        when(() => getWatchListStatusTv.execute(1))
            .thenAnswer((_) async => true);
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchTvDetail(1),
      expect: () => <TvSeriesDetailState>[
        const TvSeriesDetailState(state: RequestState.loading),
        TvSeriesDetailState(
          state: RequestState.loaded,
          tvSeriesDetail: testTvSeriesDetail,
        ),
        TvSeriesDetailState(
          state: RequestState.loaded,
          tvSeriesDetail: testTvSeriesDetail,
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should load error message when fetchTvSeriesDetail is failed',
      setUp: () {
        when(() => getTvDetail.execute(1))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        when(() => getWatchListStatusTv.execute(1))
            .thenAnswer((_) async => true);
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.fetchTvDetail(1),
      expect: () => const <TvSeriesDetailState>[
        TvSeriesDetailState(state: RequestState.loading),
        TvSeriesDetailState(
          state: RequestState.error,
          errorMessage: 'Failed',
        ),
      ],
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should change watchlist status when addWatchlist is called',
      setUp: () {
        when(() => saveWatchlistTv.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(() => getWatchListStatusTv.execute(1))
            .thenAnswer((_) async => true);
      },
      seed: () => TvSeriesDetailState(
        state: RequestState.loaded,
        tvSeriesDetail: testTvSeriesDetail,
        isAddedToWatchlist: false,
      ),
      build: () => buildCubit(),
      act: (cubit) => cubit.addWatchlist(testTvSeriesDetail),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          state: RequestState.loaded,
          tvSeriesDetail: testTvSeriesDetail,
          watchlistMessage: 'Success',
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          state: RequestState.loaded,
          tvSeriesDetail: testTvSeriesDetail,
          watchlistMessage: 'Success',
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should load watchlist error message when addWatchlist is failed',
      setUp: () {
        when(() => saveWatchlistTv.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      },
      seed: () => TvSeriesDetailState(
        state: RequestState.loaded,
        tvSeriesDetail: testTvSeriesDetail,
        isAddedToWatchlist: false,
      ),
      build: () => buildCubit(),
      act: (cubit) => cubit.addWatchlist(testTvSeriesDetail),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          state: RequestState.loaded,
          tvSeriesDetail: testTvSeriesDetail,
          watchlistMessage: 'Failed',
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should change watchlist status when removeWatchlist is called',
      setUp: () {
        when(() => removeWatchlistTv.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(() => getWatchListStatusTv.execute(1))
            .thenAnswer((_) async => false);
      },
      seed: () => TvSeriesDetailState(
        state: RequestState.loaded,
        tvSeriesDetail: testTvSeriesDetail,
        isAddedToWatchlist: true,
      ),
      build: () => buildCubit(),
      act: (cubit) => cubit.removeFromWatchlist(testTvSeriesDetail),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          state: RequestState.loaded,
          tvSeriesDetail: testTvSeriesDetail,
          watchlistMessage: 'Success',
          isAddedToWatchlist: true,
        ),
        TvSeriesDetailState(
          state: RequestState.loaded,
          tvSeriesDetail: testTvSeriesDetail,
          watchlistMessage: 'Success',
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should load watchlist error message when removeWatchlist is failed',
      setUp: () {
        when(() => removeWatchlistTv.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      },
      seed: () => TvSeriesDetailState(
        state: RequestState.loaded,
        tvSeriesDetail: testTvSeriesDetail,
        isAddedToWatchlist: true,
      ),
      build: () => buildCubit(),
      act: (cubit) => cubit.removeFromWatchlist(testTvSeriesDetail),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          state: RequestState.loaded,
          tvSeriesDetail: testTvSeriesDetail,
          watchlistMessage: 'Failed',
          isAddedToWatchlist: true,
        ),
      ],
    );
  });
}
