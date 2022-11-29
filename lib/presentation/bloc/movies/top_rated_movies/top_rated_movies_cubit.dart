import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'top_rated_movies_state.dart';

@injectable
class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  TopRatedMoviesCubit(this.getTopRatedMovies) : super(TopRatedMoviesInitial());

  final GetTopRatedMovies getTopRatedMovies;

  Future<void> fetchTopRatedMovies() async {
    emit(TopRatedMoviesLoading());
    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) => emit(TopRatedMoviesError(failure.message)),
      (moviesData) => emit(TopRatedMoviesLoaded(moviesData)),
    );
  }
}
