import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tvs_on_air_event.dart';
part 'tvs_on_air_state.dart';

class TvsOnAirBloc extends Bloc<TvsOnAirEvent, TvsOnAirState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  TvsOnAirBloc(this.getNowPlayingTvSeries) : super(TvsOnAirEmpty()) {
    on<TvsGetOnAirEvent>(
      (event, emit) async {
        emit(TvsOnAirLoading());
        final result = await getNowPlayingTvSeries.execute();

        result.fold(
          (failure) => emit(
            TvsOnAirHasError(failure.message),
          ),
          (data) => emit(
            TvsOnAirHasData(data),
          ),
        );
      },
    );
  }
}
