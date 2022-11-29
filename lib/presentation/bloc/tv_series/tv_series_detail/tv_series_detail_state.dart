// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tv_series_detail_cubit.dart';

class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState({
    this.state = RequestState.empty,
    this.tvSeriesDetail = const TvSeriesDetail.empty(),
    this.isAddedToWatchlist = false,
    this.watchlistMessage = '',
    this.errorMessage = '',
  });

  final RequestState state;
  final TvSeriesDetail tvSeriesDetail;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final String errorMessage;

  @override
  List<Object> get props => [
        state,
        tvSeriesDetail,
        isAddedToWatchlist,
        watchlistMessage,
        errorMessage,
      ];

  TvSeriesDetailState copyWith({
    RequestState? state,
    TvSeriesDetail? tvSeriesDetail,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    String? errorMessage,
  }) {
    return TvSeriesDetailState(
      state: state ?? this.state,
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
