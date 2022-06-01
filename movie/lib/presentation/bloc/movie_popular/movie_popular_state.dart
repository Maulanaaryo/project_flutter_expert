part of 'movie_popular_bloc.dart';

abstract class MoviesPopularState extends Equatable {
  const MoviesPopularState();

  @override 
  List<Object> get props => [];
}

class MoviesPopularEmpty extends MoviesPopularState {}

class MoviesPopularLoading extends MoviesPopularState {}

class MoviesPopularHasError extends MoviesPopularState {
  final String message;

  const MoviesPopularHasError(this.message);

  @override 
  List<Object> get props => [message];
}

class MoviesPopularHasData extends MoviesPopularState {
  final List<Movie> movie;

  const MoviesPopularHasData(this.movie);

  @override 
  List<Object> get props => [movie];
}