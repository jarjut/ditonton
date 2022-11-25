import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  const TvSeriesModel({
    required this.id,
    this.posterPath,
    required this.popularity,
    this.backdropPath,
    required this.voteAverage,
    required this.overview,
    this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  final int id;
  final String? posterPath;
  final double popularity;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  final String? firstAirDate;
  final List<String> originCountry;
  final List<int> genreIds;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
        id: json['id'] as int,
        posterPath: json['poster_path'] as String?,
        popularity: json['popularity'].toDouble(),
        backdropPath: json['backdrop_path'] as String?,
        voteAverage: json['vote_average'].toDouble(),
        overview: json['overview'] as String,
        firstAirDate: json['first_air_date'] as String?,
        originCountry: List<String>.from(json['origin_country'] as List),
        genreIds: List<int>.from(json['genre_ids'] as List),
        originalLanguage: json['original_language'] as String,
        voteCount: json['vote_count'] as int,
        name: json['name'] as String,
        originalName: json['original_name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'poster_path': posterPath,
        'popularity': popularity,
        'backdrop_path': backdropPath,
        'vote_average': voteAverage,
        'overview': overview,
        'first_air_date': firstAirDate,
        'origin_country': List<dynamic>.from(originCountry.map((x) => x)),
        'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
        'original_language': originalLanguage,
        'vote_count': voteCount,
        'name': name,
        'original_name': originalName,
      };

  TvSeries toEntity() => TvSeries(
        id: id,
        posterPath: posterPath,
        popularity: popularity,
        backdropPath: backdropPath,
        voteAverage: voteAverage,
        overview: overview,
        firstAirDate: firstAirDate,
        originCountry: originCountry,
        genreIds: genreIds,
        originalLanguage: originalLanguage,
        voteCount: voteCount,
        name: name,
        originalName: originalName,
      );

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
