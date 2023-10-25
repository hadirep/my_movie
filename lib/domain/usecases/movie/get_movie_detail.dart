import 'package:dartz/dartz.dart';
import 'package:my_movie/domain/entities/movie/movie_detail.dart';
import 'package:my_movie/domain/repositories/movie/movie_repository.dart';
import 'package:my_movie/common/failure.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
