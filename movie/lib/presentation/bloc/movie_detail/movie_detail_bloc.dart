import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MoviesDetailBloc extends Bloc<MoviesDetailEvent, MoviesDetailState> {
  final GetMovieDetail getMovieDetail;

  MoviesDetailBloc(this.getMovieDetail) : super(MoviesDetailEmpty()) {
    on<MoviesGetIdDetailEvent>((event, emit) async {
      emit(MoviesDetailLoading());

      final result = await getMovieDetail.execute(event.id);
      result.fold(
        (failure) => emit(
          MoviesDetailHasError(failure.message),
        ),
        (data) => emit(
          MoviesDetailHasData(data),
        ),
      );
    });
  }
}
