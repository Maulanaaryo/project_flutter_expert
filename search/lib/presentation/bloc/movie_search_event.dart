part of 'movie_search_bloc.dart';

abstract class MoviesSearchEvent extends Equatable {

  const MoviesSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends MoviesSearchEvent {
  
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
