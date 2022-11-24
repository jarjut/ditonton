import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/watchlist/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist/watchlist_tv_series_page.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_list.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:ditonton/presentation/widgets/tv_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies();
        Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
            .fetchWatchlistTvSeries();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<WatchlistMovieNotifier>(
                builder: (context, data, child) {
                  if (data.watchlistState == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.watchlistState == RequestState.loaded) {
                    if (data.watchlistMovies.isNotEmpty) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SubHeading(
                            title: 'Movies',
                            onTap: () => Navigator.pushNamed(
                              context,
                              WatchlistMoviesPage.routeName,
                            ),
                          ),
                          MovieList(data.watchlistMovies)
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  } else {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              ),
              Consumer<WatchlistTvSeriesNotifier>(
                builder: (context, data, child) {
                  if (data.watchlistState == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.watchlistState == RequestState.loaded) {
                    if (data.watchlistTvSeries.isNotEmpty) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SubHeading(
                            title: 'TV Shows',
                            onTap: () => Navigator.pushNamed(
                              context,
                              WatchlistTvSeriesPage.routeName,
                            ),
                          ),
                          TvList(data.watchlistTvSeries)
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  } else {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
