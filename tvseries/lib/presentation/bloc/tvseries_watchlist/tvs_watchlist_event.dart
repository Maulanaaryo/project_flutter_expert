part of 'tvs_watchlist_bloc.dart';

abstract class TvsWatchlistEvent extends Equatable {
  const TvsWatchlistEvent();

  @override 
  List<Object> get props => [];
}

class TvsGetWatchlistEvent extends TvsWatchlistEvent {

  @override 
  List<Object> get props => [];
}

class TvsGetIdWatchlistStatusEvent extends TvsWatchlistEvent {
  final int id;

  const TvsGetIdWatchlistStatusEvent(this.id);

  @override 
  List<Object> get props => [id];
}

class TvsAddWatchlistEvent extends TvsWatchlistEvent {
  final TvSeriesDetail tvsDetail;

  const TvsAddWatchlistEvent(this.tvsDetail);

  @override 
  List<Object> get props => [tvsDetail];
}

class TvsRemoveWatchlistEvent extends TvsWatchlistEvent {
  final TvSeriesDetail tvsDetail;

  const TvsRemoveWatchlistEvent(this.tvsDetail);

  @override 
  List<Object> get props => [tvsDetail];
}