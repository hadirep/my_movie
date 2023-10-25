import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_movie/data/models/tv_series/tv_series_model.dart';
import 'package:my_movie/data/models/tv_series/tv_series_response.dart';

import '../../../json_reader.dart';

void main() {
  const tTVSeriesModel = TVSeriesModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2],
    id: 1,
    name: 'Name',
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
  );
  const tTVSeriesResponseModel =
      TVSeriesResponse(tvSeriesList: <TVSeriesModel>[tTVSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('dummy_data/tv_series/now_playing_tv_series.json'));
      // act
      final result = TVSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2],
            "id": 1,
            "name": "Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
