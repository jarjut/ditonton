import 'package:bloc/bloc.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

@injectable
class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  SearchMoviesBloc(this.searchMovies) : super(SearchMoviesInitial()) {
    on<SearchMoviesAction>(
      (event, emit) async {
        emit(SearchMoviesLoading());
        final result = await searchMovies.execute(event.query);
        result.fold(
          (failure) => emit(SearchMoviesError(failure.message)),
          (data) => emit(SearchMoviesLoaded(data)),
        );
      },
      transformer: debounce(const Duration(milliseconds: 300)),
    );
  }

  final SearchMovies searchMovies;
}
