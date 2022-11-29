import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/bloc/movies/movie_detail/movie_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/movie_recommendation/movie_recommendation_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/popular_movies/popular_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/search_movies/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series/now_playing_tv_series/now_playing_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series/popular_tv_series/popular_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series/search_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/season_episodes/season_episodes_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_detail/tv_series_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_recommendation/tv_series_recommendation_cubit.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_tv_series/watchlist_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movies/movie_list_page.dart';
import 'package:ditonton/presentation/pages/movies/now_playing_movies_page.dart';
import 'package:ditonton/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movies/search_page.dart';
import 'package:ditonton/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_series/now_playing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/season_episodes_page.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_list_page.dart';
import 'package:ditonton/presentation/pages/watchlist/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist/watchlist_page.dart';
import 'package:ditonton/presentation/pages/watchlist/watchlist_tv_series_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<MovieDetailCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieRecommendationCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<NowPlayingMoviesCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularMoviesCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedMoviesCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<NowPlayingTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SeasonEpisodesCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvSeriesDetailCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvSeriesRecommendationCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistMovieCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistTvSeriesCubit>(),
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
        home: const MovieListPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) => appGenerateRoute(settings),
      ),
    );
  }
}

Route<dynamic>? appGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case MovieListPage.routeName:
      return MaterialPageRoute(builder: (_) => const MovieListPage());
    case NowPlayingMoviesPage.routeName:
      return CupertinoPageRoute(builder: (_) => const NowPlayingMoviesPage());
    case PopularMoviesPage.routeName:
      return CupertinoPageRoute(builder: (_) => const PopularMoviesPage());
    case TopRatedMoviesPage.routeName:
      return CupertinoPageRoute(builder: (_) => const TopRatedMoviesPage());
    case MovieDetailPage.routeName:
      final id = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => MovieDetailPage(id: id),
        settings: settings,
      );
    case TvSeriesListPage.routeName:
      return MaterialPageRoute(builder: (_) => const TvSeriesListPage());
    case NowPlayingTvSeriesPage.routeName:
      return CupertinoPageRoute(builder: (_) => const NowPlayingTvSeriesPage());
    case PopularTvSeriesPage.routeName:
      return CupertinoPageRoute(builder: (_) => const PopularTvSeriesPage());
    case TopRatedTvSeriesPage.routeName:
      return CupertinoPageRoute(builder: (_) => const TopRatedTvSeriesPage());
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
    case WatchlistPage.routeName:
      return MaterialPageRoute(builder: (_) => const WatchlistPage());
    case WatchlistMoviesPage.routeName:
      return MaterialPageRoute(builder: (_) => const WatchlistMoviesPage());
    case WatchlistTvSeriesPage.routeName:
      return MaterialPageRoute(builder: (_) => const WatchlistTvSeriesPage());
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
