import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  final int id;
  final DateTime airDate;
  final int episodeNumber;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final int showId;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  const EpisodeModel({
    required this.id,
    required this.airDate,
    required this.episodeNumber,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"],
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "air_date": airDate.toIso8601String(),
        "episode_number": episodeNumber,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  Episode toEntity() => Episode(
        id: id,
        airDate: airDate,
        episodeNumber: episodeNumber,
        name: name,
        overview: overview,
        productionCode: productionCode,
        seasonNumber: seasonNumber,
        showId: showId,
        stillPath: stillPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodeNumber,
        name,
        overview,
        productionCode,
        seasonNumber,
        showId,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
