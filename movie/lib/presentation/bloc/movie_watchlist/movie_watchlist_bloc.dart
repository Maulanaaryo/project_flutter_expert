import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MoviesWatchlistBloc
    extends Bloc<MoviesWatchlistEvent, MoviesWatchlistState> {
  final GetWatchListStatus getWatchListStatus;
  final GetWatchlistMovies getWatchlistMovies;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MoviesWatchlistBloc(this.getWatchListStatus, this.getWatchlistMovies,
      this.saveWatchlist, this.removeWatchlist)
      : super(MoviesWatchlistEmpty()) {

    on<MoviesGetWathclistEvent>((event, emit) async {
      emit(MoviesWatchlistLoading());

      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) => emit(MoviesWatchlistHasError(failure.message)),
        (data) => emit(
          MoviesWatchlistHasList(data),
        ),
      );
    });

    on<MoviesWatchlistStatusEvent>((event, emit) async {
      final id = event.id;
      emit(MoviesWatchlistLoading());

      final result = await getWatchListStatus.execute(id);
      emit(MoviesWatchlistHasStatus(result));
    });

    on<MoviesAddWatchlistEvent>((event, emit) async {
      final movie = event.movie;
      final result = await saveWatchlist.execute(movie);

      result.fold(
        (failure) => emit(
          MoviesWatchlistHasError(failure.message),
        ),
        (message) => emit(
          MoviesWatchlistSuccess(message),
        ),
      );
    });

    on<MoviesRemoveWatchlistEvent>((event, emit) async {
      final movie = event.movie;

      final result = await removeWatchlist.execute(movie);

      result.fold((failure) => emit(MoviesWatchlistHasError(failure.message)), (message) => emit(MoviesWatchlistSuccess(message)));
    });
  }
}
