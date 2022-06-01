import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tvs_watchlist_event.dart';
part 'tvs_watchlist_state.dart';

class TvsWatchlistBloc extends Bloc<TvsWatchlistEvent, TvsWatchlistState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;
  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  TvsWatchlistBloc(this.getWatchlistTvSeries, this.getWatchListStatusTvSeries,
      this.saveWatchlistTvSeries, this.removeWatchlistTvSeries)
      : super(TvsWatchlistEmpty()) {
    on<TvsGetWatchlistEvent>(
      (event, emit) async {
        emit(TvsWatchlistLoading());

        final result = await getWatchlistTvSeries.execute();

        result.fold(
          (failure) => emit(
            TvsWatchlistHasError(failure.message),
          ),
          (data) => emit(
            TvsWatchlistHasList(data),
          ),
        );
      },
    );

    on<TvsGetIdWatchlistStatusEvent>(
      (event, emit) async {
        final id = event.id;

        emit(TvsWatchlistLoading());

        final result = await getWatchListStatusTvSeries.execute(id);

        emit(
          TvsWatchlistHasStatus(result),
        );
      },
    );

    on<TvsAddWatchlistEvent>(
      (event, emit) async {
        final tvs = event.tvsDetail;

        final result = await saveWatchlistTvSeries.execute(tvs);

        result.fold(
          (failure) => emit(
            TvsWatchlistHasError(failure.message),
          ),
          (success) => emit(
            TvsWatchlistSuccess(success),
          ),
        );
      },
    );

    on<TvsRemoveWatchlistEvent>(
      (event, emit) async {
        final tvs = event.tvsDetail;

        final result = await removeWatchlistTvSeries.execute(tvs);

        result.fold(
          (failure) => emit(
            TvsWatchlistHasError(failure.message),
          ),
          (remove) => emit(
            TvsWatchlistSuccess(remove),
          ),
        );
      },
    );
  }
}
