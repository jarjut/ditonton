import 'package:bloc/bloc.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

@injectable
class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  SearchTvSeriesBloc(this.searchTvSeries) : super(SearchTvSeriesInitial()) {
    on<SearchTvSeriesAction>(
      (event, emit) async {
        emit(SearchTvSeriesLoading());
        final result = await searchTvSeries.execute(event.query);
        result.fold(
          (failure) => emit(SearchTvSeriesError(failure.message)),
          (data) => emit(SearchTvSeriesLoaded(data)),
        );
      },
      transformer: debounce(const Duration(milliseconds: 300)),
    );
  }

  final SearchTvSeries searchTvSeries;
}
