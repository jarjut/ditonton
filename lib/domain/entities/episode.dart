import 'package:equatable/equatable.dart';

class Episode extends Equatable {
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

  const Episode({
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
