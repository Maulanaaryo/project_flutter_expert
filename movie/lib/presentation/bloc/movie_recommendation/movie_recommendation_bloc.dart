import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MoviesRecommendationBloc
    extends Bloc<MoviesRecommendationEvent, MoviesRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MoviesRecommendationBloc(this.getMovieRecommendations)
      : super(MoviesRecommendationEmpty()) {
    on<MoviesGetIdRecommendationEvent>((event, emit) async {
      final id = event.id;

      emit(MoviesRecommendationLoading());

      final result = await getMovieRecommendations.execute(id);

      result.fold(
        (failure) => emit(
          MoviesRecommendationHasError(failure.message),
        ),
        (data) => emit(
          MoviesRecommendationHasData(data),
        ),
      );
    });
  }
}
