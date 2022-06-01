import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tvs_recommendation_event.dart';
part 'tvs_recommendation_state.dart';

class TvsRecommendationBloc
    extends Bloc<TvsRecommendationEvent, TvsRecommendationState> {
  final GetRecommendationsTvSeries getRecommendationsTvSeries;

  TvsRecommendationBloc(this.getRecommendationsTvSeries)
      : super(TvsRecommendationEmpty()) {
    on<TvsGetIdRecommendationEvent>(
      (event, emit) async {
        final id = event.id;

        emit(TvsRecommendationLoading());

        final result = await getRecommendationsTvSeries.execute(id);

        result.fold(
          (failure) => emit(
            TvsRecommendationHasError(failure.message),
          ),
          (data) => emit(
            TvsRecommendationHasData(data),
          ),
        );
      },
    );
  }
}
