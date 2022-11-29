import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series/season_episodes/season_episodes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeasonEpisodesArgument {
  final TvSeriesDetail tvSeriesDetail;
  final Season season;

  SeasonEpisodesArgument({
    required this.tvSeriesDetail,
    required this.season,
  });
}

class SeasonEpisodesPage extends StatefulWidget {
  static const routeName = '/season-episodes';

  const SeasonEpisodesPage({
    super.key,
    required this.tvSeriesDetail,
    required this.season,
  });

  final TvSeriesDetail tvSeriesDetail;
  final Season season;

  @override
  State<SeasonEpisodesPage> createState() => _SeasonEpisodesPageState();
}

class _SeasonEpisodesPageState extends State<SeasonEpisodesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<SeasonEpisodesCubit>(context).fetchSeasonEpisodes(
        widget.tvSeriesDetail.id,
        widget.season.seasonNumber,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Season ${widget.season.seasonNumber}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<SeasonEpisodesCubit, SeasonEpisodesState>(
          builder: (context, state) {
            if (state is SeasonEpisodesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeasonEpisodesError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is SeasonEpisodesLoaded) {
              if (state.episodes.isEmpty) {
                return const Center(
                  child: Text('No episode found'),
                );
              } else {
                return ListView.builder(
                  itemCount: state.episodes.length,
                  itemBuilder: (context, index) {
                    final episode = state.episodes[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Colors.black26,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                          ),
                          colorFilter: const ColorFilter.mode(
                            Colors.black45,
                            BlendMode.darken,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${episode.episodeNumber}. ${episode.name}',
                            style: kSubtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            episode.overview,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }

            return Container();
          },
        ),
      ),
    );
  }
}
