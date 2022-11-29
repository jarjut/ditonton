import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_tv_series/watchlist_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/watchlist/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist/watchlist_tv_series_page.dart';
import 'package:ditonton/presentation/widgets/movie_list.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:ditonton/presentation/widgets/tv_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        BlocProvider.of<WatchlistMovieCubit>(context).fetchWatchlistMovies();
        BlocProvider.of<WatchlistTvSeriesCubit>(context)
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
    BlocProvider.of<WatchlistMovieCubit>(context).fetchWatchlistMovies();
    BlocProvider.of<WatchlistTvSeriesCubit>(context).fetchWatchlistTvSeries();
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
              BlocBuilder<WatchlistMovieCubit, WatchlistMovieState>(
                builder: (context, state) {
                  if (state is WatchlistMovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WatchlistMovieLoaded) {
                    if (state.movies.isNotEmpty) {
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
                          MovieList(state.movies)
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  } else if (state is WatchlistMovieError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              BlocBuilder<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
                builder: (context, state) {
                  if (state is WatchlistTvSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WatchlistTvSeriesLoaded) {
                    if (state.tvSeries.isNotEmpty) {
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
                          TvList(state.tvSeries)
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  } else if (state is WatchlistTvSeriesError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox.shrink();
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
