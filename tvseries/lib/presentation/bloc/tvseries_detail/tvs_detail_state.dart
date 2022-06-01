part of 'tvs_detail_bloc.dart';

abstract class TvsDetailState extends Equatable {
  const TvsDetailState();

  @override 
  List<Object> get props => [];
}

class TvsDetailEmpty extends TvsDetailState {}

class TvsDetailLoading extends TvsDetailState {}

class TvsDetailHasError extends TvsDetailState{
  final String message;

  const TvsDetailHasError(this.message);

  @override 
  List<Object> get props => [message];
}

class TvsDetailHasData extends TvsDetailState {
  final TvSeriesDetail tvsDetail;

  const TvsDetailHasData(this.tvsDetail);

  @override 
  List<Object> get props => [tvsDetail];
}