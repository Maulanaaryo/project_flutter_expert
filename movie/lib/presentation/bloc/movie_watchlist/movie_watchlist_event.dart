part of 'movie_watchlist_bloc.dart';

abstract class MoviesWatchlistEvent extends Equatable {
  const MoviesWatchlistEvent();

  @override 
  List<Object> get props => [];
}

class MoviesGetWathclistEvent extends MoviesWatchlistEvent{
  
  @override 
  List<Object> get props => [];
}

class MoviesWatchlistStatusEvent extends MoviesWatchlistEvent {
  final int id;
  const MoviesWatchlistStatusEvent(this.id);

  @override 
  List<Object> get props => [id];
}

class MoviesAddWatchlistEvent extends MoviesWatchlistEvent {
  final MovieDetail movie;
  const MoviesAddWatchlistEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class MoviesRemoveWatchlistEvent extends MoviesWatchlistEvent {
  final MovieDetail movie;
  const MoviesRemoveWatchlistEvent(this.movie);

  @override 
  List<Object> get props => [movie];
}