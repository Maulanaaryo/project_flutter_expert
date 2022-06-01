part of 'tvseries_search_bloc.dart';

abstract class TvsSearchState extends Equatable {
  const TvsSearchState();

  @override
  List<Object> get props => [];
}

class TvsSearchEmpty extends TvsSearchState {}

class TvsSearchLoading extends TvsSearchState {}

class TvsSearchHasError extends TvsSearchState {
  final String message;

  const TvsSearchHasError(this.message);

  @override
  List<Object> get props => [message];
}

class TvsSearchHasData extends TvsSearchState {
  final List<TvSeries> result;

  const TvsSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
