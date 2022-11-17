import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailModel extends Equatable {
  const TvSeriesDetailModel({
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
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  final EpisodeModel? lastEpisodeToAir;
  final String name;
  final EpisodeModel? nextEpisodeToAir;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<SeasonModel> seasons;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  factory TvSeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailModel(
        id: json["id"],
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        backdropPath: json["backdrop_path"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<GenreModel>.from(
          json["genres"].map((x) => GenreModel.fromJson(x)),
        ),
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
        adult: json["adult"],
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        homepage: json["homepage"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        lastEpisodeToAir: json["last_episode_to_air"] == null
            ? null
            : EpisodeModel.fromJson(json["last_episode_to_air"]),
        nextEpisodeToAir: json["next_episode_to_air"] == null
            ? null
            : EpisodeModel.fromJson(json["next_episode_to_air"]),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        seasons: List<SeasonModel>.from(
          json["seasons"].map((x) => SeasonModel.fromJson(x)),
        ),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster_path": posterPath,
        "popularity": popularity,
        "backdrop_path": backdropPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date": firstAirDate.toIso8601String(),
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
        "adult": adult,
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "homepage": homepage,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date": lastAirDate.toIso8601String(),
        "last_episode_to_air":
            lastEpisodeToAir == null ? null : lastEpisodeToAir!.toJson(),
        "next_episode_to_air":
            nextEpisodeToAir == null ? null : nextEpisodeToAir!.toJson(),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
      };

  TvSeriesDetail toEntity() => TvSeriesDetail(
        id: id,
        posterPath: posterPath,
        popularity: popularity,
        backdropPath: backdropPath,
        voteAverage: voteAverage,
        overview: overview,
        firstAirDate: firstAirDate,
        genres: genres.map((e) => e.toEntity()).toList(),
        originCountry: originCountry,
        originalLanguage: originalLanguage,
        voteCount: voteCount,
        name: name,
        originalName: originalName,
        adult: adult,
        episodeRunTime: episodeRunTime,
        homepage: homepage,
        inProduction: inProduction,
        languages: languages,
        lastAirDate: lastAirDate,
        lastEpisodeToAir: lastEpisodeToAir?.toEntity(),
        nextEpisodeToAir: nextEpisodeToAir?.toEntity(),
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons,
        seasons: seasons.map((e) => e.toEntity()).toList(),
        status: status,
        tagline: tagline,
        type: type,
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
