import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tvs_popular_event.dart';
part 'tvs_popular_state.dart';

class TvsPopularBloc extends Bloc<TvsPopularEvent, TvsPopularState> {
  final GetPopularTvSeries getPopularTvSeries;

  TvsPopularBloc(this.getPopularTvSeries) : super(TvsPopularEmpty()) {
    on<TvsGetPopularEvent>(
      (event, emit) async {
        emit(TvsPopularLoading());

        final result = await getPopularTvSeries.execute();

        result.fold(
          (failure) => emit(
            TvsPopularHasError(failure.message),
          ),
          (data) => emit(
            TvsPopularHasData(data),
          ),
        );
      },
    );
  }
}
