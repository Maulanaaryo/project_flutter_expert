import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviesPopularBloc extends Bloc<MoviesPopularEvent, MoviesPopularState> {
  final GetPopularMovies getPopularMovies;

  MoviesPopularBloc(this.getPopularMovies) : super(MoviesPopularEmpty()) {
    on<MoviesGetPopularEvent>((event, emit) async {
      emit(MoviesPopularLoading());

      final result = await getPopularMovies.execute();

      result.fold(
        (failure) => emit(
          MoviesPopularHasError(failure.message),
        ),
        (data) => emit(
          MoviesPopularHasData(data),
        ),
      );
    });
  }
}
