import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tvs_detail_event.dart';
part 'tvs_detail_state.dart';

class TvsDetailBloc extends Bloc<TvsDetailEvent, TvsDetailState> {
  final GetDetailTvSeries getDetailTvSeries;

  TvsDetailBloc(this.getDetailTvSeries) : super(TvsDetailEmpty()) {
    on<TvsGetIdDetailEvent>(
      (event, emit) async {
        emit(TvsDetailLoading());

        final result = await getDetailTvSeries.execute(event.id);

        result.fold(
          (failure) => emit(
            TvsDetailHasError(failure.message),
          ),
          (data) => emit(
            TvsDetailHasData(data),
          ),
        );
      },
    );
  }
}
