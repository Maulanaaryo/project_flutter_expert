part of 'tvs_recommendation_bloc.dart';

abstract class TvsRecommendationEvent extends Equatable {
  const TvsRecommendationEvent();

  @override 
  List<Object> get props => [];
}

class TvsGetIdRecommendationEvent extends TvsRecommendationEvent {
  final int id;

  const TvsGetIdRecommendationEvent(this.id);

  @override 
  List<Object> get props => [id];
}