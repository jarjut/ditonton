import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'tv_series_detail_state.dart';

@injectable
class TvSeriesDetailCubit extends Cubit<TvSeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvSeriesDetailCubit({
    required this.getTvDetail,
    required this.getWatchListStatusTv,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  }) : super(const TvSeriesDetailState());

  final GetTvDetail getTvDetail;
  final GetWatchListStatusTv getWatchListStatusTv;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  Future<void> fetchTvDetail(int id) async {
    emit(const TvSeriesDetailState(state: RequestState.loading));
    final detailResult = await getTvDetail.execute(id);
    detailResult.fold(
      (failure) => emit(
        TvSeriesDetailState(
          state: RequestState.error,
          errorMessage: failure.message,
        ),
      ),
      (data) async {
        emit(
          TvSeriesDetailState(
            state: RequestState.loaded,
            tvSeriesDetail: data,
          ),
        );
        await loadWatchlistStatus(id);
      },
    );
  }

  Future<void> addWatchlist(TvSeriesDetail tv) async {
    final result = await saveWatchlistTv.execute(tv);

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            watchlistMessage: failure.message,
          ),
        );
      },
      (successMessage) async {
        emit(
          state.copyWith(
            watchlistMessage: successMessage,
          ),
        );
        await loadWatchlistStatus(tv.id);
      },
    );
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tv) async {
    final result = await removeWatchlistTv.execute(tv);

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            watchlistMessage: failure.message,
          ),
        );
      },
      (successMessage) async {
        emit(
          state.copyWith(
            watchlistMessage: successMessage,
          ),
        );
        await loadWatchlistStatus(tv.id);
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTv.execute(id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
