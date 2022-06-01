part of 'tvseries_search_bloc.dart';

abstract class TvsSearchEvent extends Equatable {
  
  const TvsSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedTv extends TvsSearchEvent {

  final String query;

  const OnQueryChangedTv(this.query);

  @override
  List<Object> get props => [query];
}
