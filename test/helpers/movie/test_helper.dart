import 'package:my_movie/data/datasources/db/movie/database_helper.dart';
import 'package:my_movie/data/datasources/movie/movie_local_data_source.dart';
import 'package:my_movie/data/datasources/movie/movie_remote_data_source.dart';
import 'package:my_movie/domain/repositories/movie/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelperMovie,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
