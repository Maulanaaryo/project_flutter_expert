import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/search.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MoviesSearchBloc extends Bloc<MoviesSearchEvent, MoviesSearchState> {
  final SearchMovies _searchMovies;

  MoviesSearchBloc(this._searchMovies) : super(MoviesSearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(MoviesSearchLoading());

        final result = await _searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(
              MoviesSearchHasError(failure.message),
            );
          },
          (data) {
            data.isEmpty
                ? emit(MoviesSearchEmpty())
                : emit(MoviesSearchHasData(data));
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
