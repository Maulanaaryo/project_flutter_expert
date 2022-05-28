import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';

class RemoveWatchlistTvSeries {
  final TvRepository repository;

  RemoveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    
    return repository.removeWatchlistTvSeries(tv);
  }
}