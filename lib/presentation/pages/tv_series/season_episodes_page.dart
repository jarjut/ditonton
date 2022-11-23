import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/provider/season_episodes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Provider.of<SeasonEpisodesNotifier>(context, listen: false)
          .fetchSeasonEpisodes(
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
        child: Consumer<SeasonEpisodesNotifier>(
          builder: (context, provider, child) {
            if (provider.episodeListState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.episodeListState == RequestState.error) {
              return Center(
                child: Text(provider.message),
              );
            } else {
              if (provider.episodeList.isEmpty) {
                return const Center(
                  child: Text('No episode found'),
                );
              } else {
                return ListView.builder(
                  itemCount: provider.episodeList.length,
                  itemBuilder: (context, index) {
                    final episode = provider.episodeList[index];
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
          },
        ),
      ),
    );
  }
}
