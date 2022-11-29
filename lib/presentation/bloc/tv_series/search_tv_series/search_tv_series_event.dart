part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class SearchTvSeriesAction extends SearchTvSeriesEvent {
  final String query;

  const SearchTvSeriesAction(this.query);

  @override
  List<Object> get props => [query];
}
