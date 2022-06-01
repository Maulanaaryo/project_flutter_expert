part of 'movie_watchlist_bloc.dart';

abstract class MoviesWatchlistState extends Equatable {
  const MoviesWatchlistState();

  @override 
  List<Object> get props => [];
}

class MoviesWatchlistEmpty extends MoviesWatchlistState {}

class MoviesWatchlistLoading extends MoviesWatchlistState {}

class MoviesWatchlistHasError extends MoviesWatchlistState {
  final String message;
  const MoviesWatchlistHasError(this.message);

  @override 
  List<Object> get props => [message];
}

class MoviesWatchlistHasList extends MoviesWatchlistState {
  final List<Movie> movie;
  const MoviesWatchlistHasList(this.movie);

  @override 
  List<Object> get props => [movie];
}

class MoviesWatchlistHasStatus extends MoviesWatchlistState {
  final bool status;
  const MoviesWatchlistHasStatus(this.status);

  @override 
  List<Object> get props => [status];
}

class MoviesWatchlistSuccess extends MoviesWatchlistState {
  final String message;
  const MoviesWatchlistSuccess(this.message);

  @override 
  List<Object> get props => [message];
}

