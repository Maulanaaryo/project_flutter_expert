part of 'movie_detail_bloc.dart';

abstract class MoviesDetailState extends Equatable {

  const MoviesDetailState();

  @override 
  List<Object> get props => [];
}

class MoviesDetailEmpty extends MoviesDetailState {}

class MoviesDetailLoading extends MoviesDetailState {}

class MoviesDetailHasError extends MoviesDetailState {

  final String message;

  const MoviesDetailHasError(this.message);

  @override 
  List<Object> get props => [message];
}

class MoviesDetailHasData extends MoviesDetailState {
  final MovieDetail movie;

  const MoviesDetailHasData(this.movie);

  @override 
  List<Object> get props => [movie];
}
