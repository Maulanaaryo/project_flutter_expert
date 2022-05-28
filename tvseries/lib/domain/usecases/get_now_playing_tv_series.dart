import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';

class GetNowPlayingTvSeries {
  final TvRepository repository;

  GetNowPlayingTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    
    return repository.getNowPlayingTvSeries();
  }
}
