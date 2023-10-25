import 'package:my_movie/data/models/tv_series/tv_series_table.dart';
import 'package:my_movie/domain/entities/genre.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series_detail.dart';

final testTVSeries = TVSeries(
  backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
  genreIds: const [18, 9648],
  id: 31917,
  name: 'Pretty Little Liars',
  overview:
      'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name "A" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
  popularity: 47.432451,
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
  voteAverage: 5.04,
  voteCount: 133,
);

final testTVSeriesList = [testTVSeries];

TVSeriesDetail testTVSeriesDetail = TVSeriesDetail(
  backdropPath: 'backdropPath',
  genres: const [Genre(id: 1, name: 'Action')],
  id: 1,
  name: 'name',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTVSeries = TVSeries.watchlistTVSeries(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTVSeriesTable = TVSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
