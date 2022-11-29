import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'popular_movies_state.dart';

@injectable
class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit(this.getPopularMovies) : super(PopularMoviesInitial());

  final GetPopularMovies getPopularMovies;

  Future<void> fetchPopularMovies() async {
    emit(PopularMoviesLoading());
    final result = await getPopularMovies.execute();

    result.fold(
      (failure) => emit(PopularMoviesError(failure.message)),
      (moviesData) => emit(PopularMoviesLoaded(moviesData)),
    );
  }
}
