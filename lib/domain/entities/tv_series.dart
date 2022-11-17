import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  const TvSeries({
    required this.id,
    this.posterPath,
    this.popularity,
    this.backdropPath,
    this.voteAverage,
    this.overview,
    this.firstAirDate,
    this.originCountry,
    this.genreIds,
    this.originalLanguage,
    this.voteCount,
    this.name,
    this.originalName,
  });

  final int id;
  final String? posterPath;
  final double? popularity;
  final String? backdropPath;
  final double? voteAverage;
  final String? overview;
  final String? firstAirDate;
  final List<String>? originCountry;
  final List<int>? genreIds;
  final String? originalLanguage;
  final int? voteCount;
  final String? name;
  final String? originalName;

  @override
  List<Object?> get props => [
        id,
        posterPath,
        popularity,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName,
      ];
}
