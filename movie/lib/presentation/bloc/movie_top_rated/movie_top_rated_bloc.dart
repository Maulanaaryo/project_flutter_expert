import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MoviesTopRatedBloc
    extends Bloc<MoviesTopRatedEvent, MoviesTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;

  MoviesTopRatedBloc(this.getTopRatedMovies) : super(MoviesTopRatedEmpty()) {
    on<MoviesGetTopRatedEvent>((event, emit) async {
      emit(MoviesTopRatedLoading());
      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(
          MoviesTopRatedHasError(failure.message),
        ),
        (data) => emit(
          MoviesTopRatedHasData(data),
        ),
      );
    });
  }
}
