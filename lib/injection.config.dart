// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i5;
import 'package:ditonton/data/datasources/movie_local_data_source.dart' as _i6;
import 'package:ditonton/data/datasources/movie_remote_data_source.dart' as _i7;
import 'package:ditonton/data/datasources/tv_local_data_source.dart' as _i14;
import 'package:ditonton/data/datasources/tv_remote_data_source.dart' as _i15;
import 'package:ditonton/data/repositories/movie_repository_impl.dart' as _i9;
import 'package:ditonton/data/repositories/tv_repository_impl.dart' as _i17;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i4;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i16;
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart' as _i18;
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart'
    as _i19;
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart'
    as _i3;
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart' as _i21;
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart'
    as _i24;
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart'
    as _i30;
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart'
    as _i28;
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart' as _i10;
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart' as _i11;
import 'package:ditonton/domain/usecases/movie/search_movies.dart' as _i12;
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tv_series.dart'
    as _i20;
import 'package:ditonton/domain/usecases/tvseries/get_popular_tv_series.dart'
    as _i22;
import 'package:ditonton/domain/usecases/tvseries/get_season_episodes.dart'
    as _i23;
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tv_series.dart'
    as _i25;
import 'package:ditonton/domain/usecases/tvseries/get_tv_detail.dart' as _i26;
import 'package:ditonton/domain/usecases/tvseries/get_tv_recommendations.dart'
    as _i27;
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_status_tv.dart'
    as _i29;
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv_series.dart'
    as _i31;
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tv.dart'
    as _i38;
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tv.dart'
    as _i39;
import 'package:ditonton/domain/usecases/tvseries/search_tv_series.dart'
    as _i40;
import 'package:ditonton/injection.dart' as _i49;
import 'package:ditonton/presentation/bloc/movies/movie_detail/movie_detail_cubit.dart'
    as _i32;
import 'package:ditonton/presentation/bloc/movies/movie_recommendation/movie_recommendation_cubit.dart'
    as _i48;
import 'package:ditonton/presentation/bloc/movies/now_playing_movies/now_playing_movies_cubit.dart'
    as _i34;
import 'package:ditonton/presentation/bloc/movies/popular_movies/popular_movies_cubit.dart'
    as _i36;
import 'package:ditonton/presentation/bloc/movies/search_movies/search_movies_bloc.dart'
    as _i13;
import 'package:ditonton/presentation/bloc/movies/top_rated_movies/top_rated_movies_cubit.dart'
    as _i43;
import 'package:ditonton/presentation/bloc/tv_series/now_playing_tv_series/now_playing_tv_series_cubit.dart'
    as _i35;
import 'package:ditonton/presentation/bloc/tv_series/popular_tv_series/popular_tv_series_cubit.dart'
    as _i37;
import 'package:ditonton/presentation/bloc/tv_series/search_tv_series/search_tv_series_bloc.dart'
    as _i41;
import 'package:ditonton/presentation/bloc/tv_series/season_episodes/season_episodes_cubit.dart'
    as _i42;
import 'package:ditonton/presentation/bloc/tv_series/top_rated_tv_series/top_rated_tv_series_cubit.dart'
    as _i44;
import 'package:ditonton/presentation/bloc/tv_series/tv_series_detail/tv_series_detail_cubit.dart'
    as _i45;
import 'package:ditonton/presentation/bloc/tv_series/tv_series_recommendation/tv_series_recommendation_cubit.dart'
    as _i46;
import 'package:ditonton/presentation/bloc/watchlist/watchlist_movie/watchlist_movie_cubit.dart'
    as _i47;
import 'package:ditonton/presentation/bloc/watchlist/watchlist_tv_series/watchlist_tv_series_cubit.dart'
    as _i33;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.GetNowPlayingMovies>(
        () => _i3.GetNowPlayingMovies(gh<_i4.MovieRepository>()));
    gh.lazySingleton<_i5.DatabaseHelper>(() => registerModule.databaseHelper);
    gh.lazySingleton<_i6.MovieLocalDataSource>(() =>
        _i6.MovieLocalDataSourceImpl(databaseHelper: gh<_i5.DatabaseHelper>()));
    gh.lazySingleton<_i7.MovieRemoteDataSource>(
        () => _i7.MovieRemoteDataSourceImpl(client: gh<_i8.Client>()));
    gh.lazySingleton<_i4.MovieRepository>(() => _i9.MovieRepositoryImpl(
          remoteDataSource: gh<_i7.MovieRemoteDataSource>(),
          localDataSource: gh<_i6.MovieLocalDataSource>(),
        ));
    gh.lazySingleton<_i10.RemoveWatchlist>(
        () => _i10.RemoveWatchlist(gh<_i4.MovieRepository>()));
    gh.lazySingleton<_i11.SaveWatchlist>(
        () => _i11.SaveWatchlist(gh<_i4.MovieRepository>()));
    gh.lazySingleton<_i12.SearchMovies>(
        () => _i12.SearchMovies(gh<_i4.MovieRepository>()));
    gh.factory<_i13.SearchMoviesBloc>(
        () => _i13.SearchMoviesBloc(gh<_i12.SearchMovies>()));
    gh.lazySingleton<_i14.TvLocalDataSource>(() =>
        _i14.TvLocalDataSourceImpl(databaseHelper: gh<_i5.DatabaseHelper>()));
    gh.lazySingleton<_i15.TvRemoteDataSource>(
        () => _i15.TvRemoteDataSourceImpl(client: gh<_i8.Client>()));
    gh.lazySingleton<_i16.TvRepository>(() => _i17.TvRepositoryImpl(
          remoteDataSource: gh<_i15.TvRemoteDataSource>(),
          localDataSource: gh<_i14.TvLocalDataSource>(),
        ));
    gh.lazySingleton<_i18.GetMovieDetail>(
        () => _i18.GetMovieDetail(gh<_i4.MovieRepository>()));
    gh.lazySingleton<_i19.GetMovieRecommendations>(
        () => _i19.GetMovieRecommendations(gh<_i4.MovieRepository>()));
    gh.lazySingleton<_i8.Client>(() => registerModule.client);
    gh.lazySingleton<_i20.GetNowPlayingTvSeries>(
        () => _i20.GetNowPlayingTvSeries(gh<_i16.TvRepository>()));
    gh.lazySingleton<_i21.GetPopularMovies>(
        () => _i21.GetPopularMovies(gh<_i4.MovieRepository>()));
    gh.lazySingleton<_i22.GetPopularTvSeries>(
        () => _i22.GetPopularTvSeries(gh<_i16.TvRepository>()));
    gh.lazySingleton<_i23.GetSeasonEpisodes>(
        () => _i23.GetSeasonEpisodes(gh<_i16.TvRepository>()));
    gh.lazySingleton<_i24.GetTopRatedMovies>(
        () => _i24.GetTopRatedMovies(gh<_i4.MovieRepository>()));
    gh.lazySingleton<_i25.GetTopRatedTvSeries>(
        () => _i25.GetTopRatedTvSeries(gh<_i16.TvRepository>()));
    gh.lazySingleton<_i26.GetTvDetail>(
        () => _i26.GetTvDetail(gh<_i16.TvRepository>()));
    gh.lazySingleton<_i27.GetTvRecommendations>(
        () => _i27.GetTvRecommendations(gh<_i16.TvRepository>()));
    gh.lazySingleton<_i28.GetWatchListStatus>(
        () => _i28.GetWatchListStatus(gh<_i4.MovieRepository>()));
    gh.lazySingleton<_i29.GetWatchListStatusTv>(
        () => _i29.GetWatchListStatusTv(gh<_i16.TvRepository>()));
    gh.lazySingleton<_i30.GetWatchlistMovies>(
        () => _i30.GetWatchlistMovies(gh<_i4.MovieRepository>()));
    gh.lazySingleton<_i31.GetWatchlistTvSeries>(
        () => _i31.GetWatchlistTvSeries(gh<_i16.TvRepository>()));
    gh.factory<_i32.MovieDetailCubit>(() => _i32.MovieDetailCubit(
          getMovieDetail: gh<_i18.GetMovieDetail>(),
          getWatchListStatus: gh<_i28.GetWatchListStatus>(),
          saveWatchlist: gh<_i11.SaveWatchlist>(),
          removeWatchlist: gh<_i10.RemoveWatchlist>(),
        ));
    gh.factory<_i33.WatchlistTvSeriesCubit>(
        () => _i33.WatchlistTvSeriesCubit(gh<_i31.GetWatchlistTvSeries>()));
    gh.factory<_i34.NowPlayingMoviesCubit>(
        () => _i34.NowPlayingMoviesCubit(gh<_i3.GetNowPlayingMovies>()));
    gh.factory<_i35.NowPlayingTvSeriesCubit>(
        () => _i35.NowPlayingTvSeriesCubit(gh<_i20.GetNowPlayingTvSeries>()));
    gh.factory<_i36.PopularMoviesCubit>(
        () => _i36.PopularMoviesCubit(gh<_i21.GetPopularMovies>()));
    gh.factory<_i37.PopularTvSeriesCubit>(
        () => _i37.PopularTvSeriesCubit(gh<_i22.GetPopularTvSeries>()));
    gh.lazySingleton<_i38.RemoveWatchlistTv>(
        () => _i38.RemoveWatchlistTv(gh<_i16.TvRepository>()));
    gh.lazySingleton<_i39.SaveWatchlistTv>(
        () => _i39.SaveWatchlistTv(gh<_i16.TvRepository>()));
    gh.lazySingleton<_i40.SearchTvSeries>(
        () => _i40.SearchTvSeries(gh<_i16.TvRepository>()));
    gh.factory<_i41.SearchTvSeriesBloc>(
        () => _i41.SearchTvSeriesBloc(gh<_i40.SearchTvSeries>()));
    gh.factory<_i42.SeasonEpisodesCubit>(
        () => _i42.SeasonEpisodesCubit(gh<_i23.GetSeasonEpisodes>()));
    gh.factory<_i43.TopRatedMoviesCubit>(
        () => _i43.TopRatedMoviesCubit(gh<_i24.GetTopRatedMovies>()));
    gh.factory<_i44.TopRatedTvSeriesCubit>(
        () => _i44.TopRatedTvSeriesCubit(gh<_i25.GetTopRatedTvSeries>()));
    gh.factory<_i45.TvSeriesDetailCubit>(() => _i45.TvSeriesDetailCubit(
          getTvDetail: gh<_i26.GetTvDetail>(),
          getWatchListStatusTv: gh<_i29.GetWatchListStatusTv>(),
          saveWatchlistTv: gh<_i39.SaveWatchlistTv>(),
          removeWatchlistTv: gh<_i38.RemoveWatchlistTv>(),
        ));
    gh.factory<_i46.TvSeriesRecommendationCubit>(() =>
        _i46.TvSeriesRecommendationCubit(gh<_i27.GetTvRecommendations>()));
    gh.factory<_i47.WatchlistMovieCubit>(
        () => _i47.WatchlistMovieCubit(gh<_i30.GetWatchlistMovies>()));
    gh.factory<_i48.MovieRecommendationCubit>(() =>
        _i48.MovieRecommendationCubit(
            getMovieRecommendations: gh<_i19.GetMovieRecommendations>()));
    return this;
  }
}

class _$RegisterModule extends _i49.RegisterModule {}
