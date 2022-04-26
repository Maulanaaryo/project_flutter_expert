import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:flutter/foundation.dart';

class TvSeriesWatchlistNotifier extends ChangeNotifier {
  var _watchlistTv = <TvSeries>[];
  List<TvSeries> get watchlistTv => _watchlistTv;

  var _watchlistTvState = RequestState.Empty;
  RequestState get watchlistTvState => _watchlistTvState;

  String _message = '';
  String get message => _message;

  TvSeriesWatchlistNotifier({required this.getWatchlistTvSeries});

  final GetWatchlistTvSeries getWatchlistTvSeries;

  Future<void> fetchWatchlistTv() async {
    _watchlistTvState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        _watchlistTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistTvState = RequestState.Loaded;
        _watchlistTv = tvData;
        notifyListeners();
      },
    );
  }
}