import 'package:ditonton/data/models/episode_model.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailResponse extends Equatable {
  final List<EpisodeModel> episodeList;

  const SeasonDetailResponse({required this.episodeList});

  factory SeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      SeasonDetailResponse(
        episodeList: List<EpisodeModel>.from(
          (json["episodes"] as List).map((x) => EpisodeModel.fromJson(x)),
        ),
      );

  @override
  List<Object> get props => [episodeList];
}
