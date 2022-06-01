import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';

class GetRecommendationsTvSeries {

  final TvRepository repository;

  GetRecommendationsTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) { 
    
    return repository.getTvSeriesRecommendations(id);
  }
}