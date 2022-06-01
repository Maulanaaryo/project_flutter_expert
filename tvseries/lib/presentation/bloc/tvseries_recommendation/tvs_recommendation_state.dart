part of 'tvs_recommendation_bloc.dart';

abstract class TvsRecommendationState extends Equatable {
  const TvsRecommendationState();

  @override 
  List<Object> get props => [];
}

class TvsRecommendationEmpty extends TvsRecommendationState {}

class TvsRecommendationLoading extends TvsRecommendationState {}

class TvsRecommendationHasError extends TvsRecommendationState {
  final String message;

  const TvsRecommendationHasError(this.message);

  @override 
  List<Object> get props => [message];
}

class TvsRecommendationHasData extends TvsRecommendationState {
  final List<TvSeries> tvSeries;

  const TvsRecommendationHasData(this.tvSeries);

  @override 
  List<Object> get props => [tvSeries];
}