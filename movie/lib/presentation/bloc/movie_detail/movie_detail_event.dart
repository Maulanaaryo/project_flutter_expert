part of 'movie_detail_bloc.dart';

abstract class MoviesDetailEvent extends Equatable {
  const MoviesDetailEvent();

  @override
  List<Object> get props => [];
}

class MoviesGetIdDetailEvent extends MoviesDetailEvent {
  final int id;
  const MoviesGetIdDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
