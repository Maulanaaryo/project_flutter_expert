import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:tvseries/tvseries.dart';

class TvSeriesWatchlistNotifier extends ChangeNotifier {
  var _watchlistTv = <TvSeries>[];
  List<TvSeries> get watchlistTv => _watchlistTv;

  var _watchlistTvState = RequestState.HasEmpty;
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
        _watchlistTvState = RequestState.HasError;
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