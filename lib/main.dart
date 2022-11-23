import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/season_episodes_page.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_list_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/season_episodes_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeasonEpisodesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) => appGenerateRoute(settings),
      ),
    );
  }
}

Route<dynamic>? appGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeMoviePage.routeName:
      return MaterialPageRoute(builder: (_) => const HomeMoviePage());
    case PopularMoviesPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => const PopularMoviesPage(),
      );
    case TopRatedMoviesPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => const TopRatedMoviesPage(),
      );
    case MovieDetailPage.routeName:
      final id = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => MovieDetailPage(id: id),
        settings: settings,
      );
    case TvSeriesListPage.routeName:
      return MaterialPageRoute(builder: (_) => const TvSeriesListPage());
    case PopularTvSeriesPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => const PopularTvSeriesPage(),
      );
    case TopRatedTvSeriesPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => const TopRatedTvSeriesPage(),
      );
    case TvSeriesDetailPage.routeName:
      final id = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => TvSeriesDetailPage(id: id),
        settings: settings,
      );
    case SeasonEpisodesPage.routeName:
      final argument = settings.arguments as SeasonEpisodesArgument;
      return MaterialPageRoute(
        builder: (_) => SeasonEpisodesPage(
          tvSeriesDetail: argument.tvSeriesDetail,
          season: argument.season,
        ),
        settings: settings,
      );
    case SearchTvSeriesPage.routeName:
      return CupertinoPageRoute(builder: (_) => const SearchTvSeriesPage());
    case SearchPage.routeName:
      return CupertinoPageRoute(builder: (_) => const SearchPage());
    case WatchlistMoviesPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const WatchlistMoviesPage(),
      );
    case AboutPage.routeName:
      return MaterialPageRoute(builder: (_) => const AboutPage());
    default:
      return MaterialPageRoute(
        builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        },
      );
  }
}
