part of 'movie_now_playing_bloc.dart';

abstract class MoviesNowPlayingState extends Equatable {
  const MoviesNowPlayingState();

  @override 
  List<Object> get props => [];
}

class MoviesNowPlayingEmpty extends MoviesNowPlayingState {}

class MoviesNowPlayingLoading extends MoviesNowPlayingState {}

class MoviesNowPlayingHasError extends MoviesNowPlayingState {
  final String message;

  const MoviesNowPlayingHasError(this.message);

  @override 
  List<Object> get props  => [message];
}

class MoviesNowPlayingHasData extends MoviesNowPlayingState {
  final List<Movie> movie;

  const MoviesNowPlayingHasData(this.movie);

  @override 
  List<Object> get props => [movie];
}