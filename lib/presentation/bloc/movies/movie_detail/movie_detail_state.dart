// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState({
    this.state = RequestState.empty,
    this.movieDetail = const MovieDetail.empty(),
    this.isAddedToWatchlist = false,
    this.watchlistMessage = '',
    this.errorMessage = '',
  });

  final RequestState state;
  final MovieDetail movieDetail;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final String errorMessage;

  @override
  List<Object> get props => [
        state,
        movieDetail,
        isAddedToWatchlist,
        watchlistMessage,
        errorMessage,
      ];

  MovieDetailState copyWith({
    RequestState? state,
    MovieDetail? movieDetail,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    String? errorMessage,
  }) {
    return MovieDetailState(
      state: state ?? this.state,
      movieDetail: movieDetail ?? this.movieDetail,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
