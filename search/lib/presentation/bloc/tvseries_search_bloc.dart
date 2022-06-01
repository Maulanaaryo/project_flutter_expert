import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

part 'tvseries_search_event.dart';
part 'tvseries_search_state.dart';

class TvsSearchBloc extends Bloc<TvsSearchEvent, TvsSearchState> {
  final SearchTvSeries searchTvSeries;

  TvsSearchBloc(this.searchTvSeries) : super(TvsSearchEmpty()) {
    on<OnQueryChangedTv>(
      (event, emit) async {
        final query = event.query;
        emit(TvsSearchLoading());
        final result = await searchTvSeries.execute(query);

        result.fold(
          (failure) {
            emit(TvsSearchHasError(failure.message));
          },
          (data) {
            data.isEmpty
                ? emit(TvsSearchEmpty())
                : emit(TvsSearchHasData(data));
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
