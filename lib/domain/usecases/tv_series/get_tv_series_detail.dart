import 'package:dartz/dartz.dart';
import 'package:my_movie/domain/entities/tv_series/tv_series_detail.dart';
import 'package:my_movie/domain/repositories/tv_series/tv_series_repository.dart';
import 'package:my_movie/common/failure.dart';

class GetTVSeriesDetail {
  final TVSeriesRepository repository;

  GetTVSeriesDetail(this.repository);

  Future<Either<Failure, TVSeriesDetail>> execute(int id) {
    return repository.getTVSeriesDetail(id);
  }
}
