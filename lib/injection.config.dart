// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i4;
import 'package:ditonton/data/datasources/movie_local_data_source.dart' as _i5;
import 'package:ditonton/data/datasources/movie_remote_data_source.dart' as _i6;
import 'package:ditonton/data/datasources/tv_local_data_source.dart' as _i12;
import 'package:ditonton/data/datasources/tv_remote_data_source.dart' as _i13;
import 'package:ditonton/data/repositories/movie_repository_impl.dart' as _i8;
import 'package:ditonton/data/repositories/tv_repository_impl.dart' as _i15;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i14;
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart' as _i16;
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart'
    as _i17;
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart'
    as _i18;
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart' as _i20;
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart'
    as _i23;
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart'
    as _i29;
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart'
    as _i27;
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart' as _i9;
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart' as _i10;
import 'package:ditonton/domain/usecases/movie/search_movies.dart' as _i11;
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tv_series.dart'
    as _i19;
import 'package:ditonton/domain/usecases/tvseries/get_popular_tv_series.dart'
    as _i21;
import 'package:ditonton/domain/usecases/tvseries/get_season_episodes.dart'
    as _i22;
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tv_series.dart'
    as _i24;
import 'package:ditonton/domain/usecases/tvseries/get_tv_detail.dart' as _i25;
import 'package:ditonton/domain/usecases/tvseries/get_tv_recommendations.dart'
    as _i26;
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_status_tv.dart'
    as _i28;
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv_series.dart'
    as _i30;
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tv.dart'
    as _i31;
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tv.dart'
    as _i32;
import 'package:ditonton/domain/usecases/tvseries/search_tv_series.dart'
    as _i33;
import 'package:ditonton/injection.dart' as _i34;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
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
    gh.lazySingleton<_i3.Client>(() => registerModule.client);
    gh.lazySingleton<_i4.DatabaseHelper>(() => registerModule.databaseHelper);
    gh.lazySingleton<_i5.MovieLocalDataSource>(() =>
        _i5.MovieLocalDataSourceImpl(databaseHelper: gh<_i4.DatabaseHelper>()));
    gh.lazySingleton<_i6.MovieRemoteDataSource>(
        () => _i6.MovieRemoteDataSourceImpl(client: gh<_i3.Client>()));
    gh.lazySingleton<_i7.MovieRepository>(() => _i8.MovieRepositoryImpl(
          remoteDataSource: gh<_i6.MovieRemoteDataSource>(),
          localDataSource: gh<_i5.MovieLocalDataSource>(),
        ));
    gh.lazySingleton<_i9.RemoveWatchlist>(
        () => _i9.RemoveWatchlist(gh<_i7.MovieRepository>()));
    gh.lazySingleton<_i10.SaveWatchlist>(
        () => _i10.SaveWatchlist(gh<_i7.MovieRepository>()));
    gh.lazySingleton<_i11.SearchMovies>(
        () => _i11.SearchMovies(gh<_i7.MovieRepository>()));
    gh.lazySingleton<_i12.TvLocalDataSource>(() =>
        _i12.TvLocalDataSourceImpl(databaseHelper: gh<_i4.DatabaseHelper>()));
    gh.lazySingleton<_i13.TvRemoteDataSource>(
        () => _i13.TvRemoteDataSourceImpl(client: gh<_i3.Client>()));
    gh.lazySingleton<_i14.TvRepository>(() => _i15.TvRepositoryImpl(
          remoteDataSource: gh<_i13.TvRemoteDataSource>(),
          localDataSource: gh<_i12.TvLocalDataSource>(),
        ));
    gh.lazySingleton<_i16.GetMovieDetail>(
        () => _i16.GetMovieDetail(gh<_i7.MovieRepository>()));
    gh.lazySingleton<_i17.GetMovieRecommendations>(
        () => _i17.GetMovieRecommendations(gh<_i7.MovieRepository>()));
    gh.lazySingleton<_i18.GetNowPlayingMovies>(
        () => _i18.GetNowPlayingMovies(gh<_i7.MovieRepository>()));
    gh.lazySingleton<_i19.GetNowPlayingTvSeries>(
        () => _i19.GetNowPlayingTvSeries(gh<_i14.TvRepository>()));
    gh.lazySingleton<_i20.GetPopularMovies>(
        () => _i20.GetPopularMovies(gh<_i7.MovieRepository>()));
    gh.lazySingleton<_i21.GetPopularTvSeries>(
        () => _i21.GetPopularTvSeries(gh<_i14.TvRepository>()));
    gh.lazySingleton<_i22.GetSeasonEpisodes>(
        () => _i22.GetSeasonEpisodes(gh<_i14.TvRepository>()));
    gh.lazySingleton<_i23.GetTopRatedMovies>(
        () => _i23.GetTopRatedMovies(gh<_i7.MovieRepository>()));
    gh.lazySingleton<_i24.GetTopRatedTvSeries>(
        () => _i24.GetTopRatedTvSeries(gh<_i14.TvRepository>()));
    gh.lazySingleton<_i25.GetTvDetail>(
        () => _i25.GetTvDetail(gh<_i14.TvRepository>()));
    gh.lazySingleton<_i26.GetTvRecommendations>(
        () => _i26.GetTvRecommendations(gh<_i14.TvRepository>()));
    gh.lazySingleton<_i27.GetWatchListStatus>(
        () => _i27.GetWatchListStatus(gh<_i7.MovieRepository>()));
    gh.lazySingleton<_i28.GetWatchListStatusTv>(
        () => _i28.GetWatchListStatusTv(gh<_i14.TvRepository>()));
    gh.lazySingleton<_i29.GetWatchlistMovies>(
        () => _i29.GetWatchlistMovies(gh<_i7.MovieRepository>()));
    gh.lazySingleton<_i30.GetWatchlistTvSeries>(
        () => _i30.GetWatchlistTvSeries(gh<_i14.TvRepository>()));
    gh.lazySingleton<_i31.RemoveWatchlistTv>(
        () => _i31.RemoveWatchlistTv(gh<_i14.TvRepository>()));
    gh.lazySingleton<_i32.SaveWatchlistTv>(
        () => _i32.SaveWatchlistTv(gh<_i14.TvRepository>()));
    gh.lazySingleton<_i33.SearchTvSeries>(
        () => _i33.SearchTvSeries(gh<_i14.TvRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i34.RegisterModule {}
