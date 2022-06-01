part of 'tvs_on_air_bloc.dart';

abstract class TvsOnAirState extends Equatable {
  const TvsOnAirState();

  @override 
  List<Object> get props => [];
}

class TvsOnAirEmpty extends TvsOnAirState {}

class TvsOnAirLoading extends TvsOnAirState {}

class TvsOnAirHasError extends TvsOnAirState {
  final String message;

  const TvsOnAirHasError(this.message);

  @override 
  List<Object> get props => [message];
}

class TvsOnAirHasData extends TvsOnAirState {
  final List<TvSeries> tvSeries;

  const TvsOnAirHasData(this.tvSeries);

  @override 
  List<Object> get props => [tvSeries];
}