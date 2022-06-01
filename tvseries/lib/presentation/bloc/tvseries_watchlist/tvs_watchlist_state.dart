part of 'tvs_watchlist_bloc.dart';

abstract class TvsWatchlistState extends Equatable {
  const TvsWatchlistState();

  @override 
  List<Object> get props => [];
}

class TvsWatchlistEmpty extends TvsWatchlistState {}

class TvsWatchlistLoading extends TvsWatchlistState {}

class TvsWatchlistHasError extends TvsWatchlistState {
  final String message;

  const TvsWatchlistHasError(this.message);

  @override 
  List<Object> get props => [message];
}

class TvsWatchlistHasList extends TvsWatchlistState {
  final List<TvSeries> tvSeries;

  const TvsWatchlistHasList(this.tvSeries);

  @override 
  List<Object> get props => [tvSeries];
}

class TvsWatchlistHasStatus extends TvsWatchlistState {
  final bool status;

  const TvsWatchlistHasStatus(this.status);

  @override 
  List<Object> get props => [status];
}

class TvsWatchlistSuccess extends TvsWatchlistState {
  final String message;

  const TvsWatchlistSuccess(this.message);

  @override 
  List<Object> get props => [message];
}
