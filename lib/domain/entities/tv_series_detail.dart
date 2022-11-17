import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
    required this.id,
    this.posterPath,
    required this.popularity,
    this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    this.genres = const [],
    required this.originCountry,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
    required this.adult,
    required this.episodeRunTime,
    required this.homepage,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    this.lastEpisodeToAir,
    this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
  });

  final bool adult;
  final String? backdropPath;
  final List<int> episodeRunTime;
  final DateTime firstAirDate;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  final Episode? lastEpisodeToAir;
  final String name;
  final Episode? nextEpisodeToAir;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<Season> seasons;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        id,
        posterPath,
        popularity,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        genres,
        originCountry,
        originalLanguage,
        originalName,
        adult,
        episodeRunTime,
        homepage,
        inProduction,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        numberOfEpisodes,
        numberOfSeasons,
        seasons,
        status,
        tagline,
        type,
        voteCount,
      ];
}
