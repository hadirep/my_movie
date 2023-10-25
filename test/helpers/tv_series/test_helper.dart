import 'package:my_movie/data/datasources/db/tv_series/database_helper.dart';
import 'package:my_movie/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:my_movie/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:my_movie/domain/repositories/tv_series/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
  DatabaseHelperTVSeries,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
