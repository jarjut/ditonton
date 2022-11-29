import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'watchlist_movie_state.dart';

@injectable
class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  WatchlistMovieCubit(this.getWatchlistMovies) : super(WatchlistMovieInitial());

  final GetWatchlistMovies getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    emit(WatchlistMovieLoading());
    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) => emit(WatchlistMovieError(failure.message)),
      (moviesData) => emit(WatchlistMovieLoaded(moviesData)),
    );
  }
}
