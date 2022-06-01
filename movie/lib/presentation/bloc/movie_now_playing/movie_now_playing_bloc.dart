import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MoviesNowPlayingBloc
    extends Bloc<MoviesNowPlayingEvent, MoviesNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MoviesNowPlayingBloc(this.getNowPlayingMovies)
      : super(MoviesNowPlayingEmpty()) {
    on<MoviesGetNowPlayingEvent>((event, emit) async {
      emit(MoviesNowPlayingLoading());

      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) => emit(
          MoviesNowPlayingHasError(failure.message),
        ),
        (data) => emit(
          MoviesNowPlayingHasData(data),
        ),
      );
    });
  }
}
