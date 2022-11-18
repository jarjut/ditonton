import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

const testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

const testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

// TV Series Dummy Data

const testTvSeriesModel = TvSeriesModel(
  id: 1,
  backdropPath: "/backdropPath.jpg",
  firstAirDate: "2021-10-12",
  genreIds: [80, 10765],
  name: "Name",
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "OriginalName",
  overview: "Overview",
  popularity: 3293.494,
  posterPath: "/posterPath.jpg",
  voteAverage: 7.9,
  voteCount: 3476,
);

final testTvSeriesModelList = [testTvSeriesModel];

const testTvSeries = TvSeries(
  id: 1,
  backdropPath: "/backdropPath.jpg",
  firstAirDate: "2021-10-12",
  genreIds: [80, 10765],
  name: "Name",
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "OriginalName",
  overview: "Overview",
  popularity: 3293.494,
  posterPath: "/posterPath.jpg",
  voteAverage: 7.9,
  voteCount: 3476,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriedDetailModel = TvSeriesDetailModel(
  id: 1,
  adult: false,
  popularity: 3293.494,
  voteAverage: 3476,
  overview: "Overview",
  posterPath: "/posterPath.jpg",
  firstAirDate: DateTime(2021, 10, 12),
  originCountry: const ["US"],
  originalLanguage: "en",
  voteCount: 3476,
  name: "Name",
  originalName: "OriginalName",
  episodeRunTime: const [42],
  homepage: "https://www.syfy.com/chucky",
  inProduction: true,
  languages: const ['en'],
  lastAirDate: DateTime(2022, 11, 26),
  numberOfEpisodes: 16,
  numberOfSeasons: 2,
  seasons: [
    SeasonModel(
      airDate: DateTime(2021, 10, 12),
      episodeCount: 8,
      id: 126146,
      name: "Season 1",
      overview: "",
      posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
      seasonNumber: 1,
    ),
    SeasonModel(
      airDate: DateTime(2022, 10, 5),
      episodeCount: 8,
      id: 294576,
      name: "Season 2",
      overview: "",
      posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
      seasonNumber: 2,
    ),
  ],
  status: "Returning Series",
  tagline: "A classic coming of rage story.",
  type: "Scripted",
);

final testTvSeriedDetail = TvSeriesDetail(
  id: 1,
  adult: false,
  popularity: 3293.494,
  voteAverage: 3476,
  overview: "Overview",
  posterPath: "/posterPath.jpg",
  firstAirDate: DateTime(2021, 10, 12),
  originCountry: const ["US"],
  originalLanguage: "en",
  voteCount: 3476,
  name: "Name",
  originalName: "OriginalName",
  episodeRunTime: const [42],
  homepage: "https://www.syfy.com/chucky",
  inProduction: true,
  languages: const ['en'],
  lastAirDate: DateTime(2022, 11, 26),
  numberOfEpisodes: 16,
  numberOfSeasons: 2,
  seasons: [
    Season(
      airDate: DateTime(2021, 10, 12),
      episodeCount: 8,
      id: 126146,
      name: "Season 1",
      overview: "",
      posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
      seasonNumber: 1,
    ),
    Season(
      airDate: DateTime(2022, 10, 5),
      episodeCount: 8,
      id: 294576,
      name: "Season 2",
      overview: "",
      posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
      seasonNumber: 2,
    ),
  ],
  status: "Returning Series",
  tagline: "A classic coming of rage story.",
  type: "Scripted",
);

const testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'Name',
  posterPath: "/posterPath.jpg",
  overview: "Overview",
);

const testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'Name',
  posterPath: "/posterPath.jpg",
  overview: "Overview",
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'Overview',
  'posterPath': '/posterPath.jpg',
  'name': 'Name',
};
