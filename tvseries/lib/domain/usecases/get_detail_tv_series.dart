import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';

class GetDetailTvSeries {
  final TvRepository repository;

  GetDetailTvSeries(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {

    return repository.getTvSeriesDetail(id);
  }
}