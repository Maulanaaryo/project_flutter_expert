import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';

class SaveWatchlistTvSeries {
  
  final TvRepository repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    
    return repository.saveWatchlistTvSeries(tv);
  }
}