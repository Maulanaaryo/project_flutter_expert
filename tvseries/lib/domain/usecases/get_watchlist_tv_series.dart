import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';

class GetWatchlistTvSeries {
  final TvRepository _repository;

  GetWatchlistTvSeries(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    
    return _repository.getWatchlistTvSeries();
  }
}