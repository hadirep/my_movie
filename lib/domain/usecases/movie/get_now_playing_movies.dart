import 'package:dartz/dartz.dart';
import 'package:my_movie/domain/entities/movie/movie.dart';
import 'package:my_movie/domain/repositories/movie/movie_repository.dart';
import 'package:my_movie/common/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
