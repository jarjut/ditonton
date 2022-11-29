import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'movie_detail_state.dart';

@injectable
class MovieDetailCubit extends Cubit<MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailCubit({
    required this.getMovieDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const MovieDetailState());

  final GetMovieDetail getMovieDetail;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  Future<void> fetchMovieDetail(int id) async {
    emit(const MovieDetailState(state: RequestState.loading));
    final detailResult = await getMovieDetail.execute(id);
    detailResult.fold(
      (failure) {
        emit(
          MovieDetailState(
            state: RequestState.error,
            errorMessage: failure.message,
          ),
        );
      },
      (movie) async {
        emit(
          MovieDetailState(
            state: RequestState.loaded,
            movieDetail: movie,
          ),
        );
        await loadWatchlistStatus(id);
      },
    );
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

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
        await loadWatchlistStatus(movie.id);
      },
    );
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

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
        await loadWatchlistStatus(movie.id);
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
