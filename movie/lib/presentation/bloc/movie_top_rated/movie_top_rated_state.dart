part of 'movie_top_rated_bloc.dart';

abstract class MoviesTopRatedState extends Equatable {
  const MoviesTopRatedState();

  @override 
  List<Object> get props => [];
}

class MoviesTopRatedEmpty extends MoviesTopRatedState {}

class MoviesTopRatedLoading extends MoviesTopRatedState {}

class MoviesTopRatedHasError extends MoviesTopRatedState {
  final String message;

  const MoviesTopRatedHasError(this.message);

  @override 
  List<Object> get props => [message];
}

class MoviesTopRatedHasData extends MoviesTopRatedState{
  final List<Movie> movie;

  const MoviesTopRatedHasData(this.movie);

  @override 
  List<Object> get props => [movie];
}