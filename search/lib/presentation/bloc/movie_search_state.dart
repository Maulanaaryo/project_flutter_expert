part of 'movie_search_bloc.dart';

abstract class MoviesSearchState extends Equatable {
  const MoviesSearchState();

  @override
  List<Object> get props => [];
}

class MoviesSearchEmpty extends MoviesSearchState {}

class MoviesSearchLoading extends MoviesSearchState {}

class MoviesSearchHasError extends MoviesSearchState {
  final String message;

  const MoviesSearchHasError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesSearchHasData extends MoviesSearchState {
  final List<Movie> result;

  const MoviesSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
