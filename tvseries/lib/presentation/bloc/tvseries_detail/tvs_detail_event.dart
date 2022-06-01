part of 'tvs_detail_bloc.dart';

abstract class TvsDetailEvent extends Equatable {
  const TvsDetailEvent();

  @override 
  List<Object> get props => [];
}

class TvsGetIdDetailEvent extends TvsDetailEvent {
  final int id;

  const TvsGetIdDetailEvent(this.id);

  @override 
  List<Object> get props => [id];
}