import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'now_playing_movies_state.dart';

@injectable
class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  NowPlayingMoviesCubit(this.getNowPlayingMovies)
      : super(NowPlayingMoviesInitial());

  final GetNowPlayingMovies getNowPlayingMovies;

  Future<void> fetchNowPlayingMovies() async {
    emit(NowPlayingMoviesLoading());
    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) => emit(NowPlayingMoviesError(failure.message)),
      (moviesData) => emit(NowPlayingMoviesLoaded(moviesData)),
    );
  }
}
