import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tvs_top_rated_event.dart';
part 'tvs_top_rated_state.dart';

class TvsTopRatedBloc extends Bloc<TvsTopRatedEvent, TvsTopRatedState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvsTopRatedBloc(this.getTopRatedTvSeries) : super(TvsTopRatedEmpty()) {
    on<TvsGetTopRatedEvent>(
      (event, emit) async {
        emit(TvsTopRatedLoading());

        final result = await getTopRatedTvSeries.execute();

        result.fold(
          (failure) => emit(
            TvsTopRatedHasError(failure.message),
          ),
          (data) => emit(
            TvsTopRatedHasData(data),
          ),
        );
      },
    );
  }
}
