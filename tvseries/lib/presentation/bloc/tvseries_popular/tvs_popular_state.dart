part of 'tvs_popular_bloc.dart';

abstract class TvsPopularState extends Equatable {
  const TvsPopularState();

  @override 
  List<Object> get props => [];
}

class TvsPopularEmpty extends TvsPopularState {}

class TvsPopularLoading extends TvsPopularState {}

class TvsPopularHasError extends TvsPopularState {
  final String message;

  const TvsPopularHasError(this.message);

  @override
  List<Object> get props => [message];
}

class TvsPopularHasData extends TvsPopularState {
  final List<TvSeries> tvSeries;

  const TvsPopularHasData(this.tvSeries);

  @override 
  List<Object> get props => [tvSeries];
}