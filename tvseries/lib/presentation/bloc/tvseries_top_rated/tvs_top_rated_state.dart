part of 'tvs_top_rated_bloc.dart';

abstract class TvsTopRatedState extends Equatable {
  const TvsTopRatedState();

  @override 
  List<Object> get props => [];
}

class TvsTopRatedEmpty extends TvsTopRatedState {}

class TvsTopRatedLoading extends TvsTopRatedState {}

class TvsTopRatedHasError extends TvsTopRatedState {
  final String message;

  const TvsTopRatedHasError(this.message);

  @override 
  List<Object> get props => [message];
}

class TvsTopRatedHasData extends TvsTopRatedState {
  final List<TvSeries> tvSeries;

  const TvsTopRatedHasData(this.tvSeries);

  @override 
  List<Object> get props => [tvSeries];
}