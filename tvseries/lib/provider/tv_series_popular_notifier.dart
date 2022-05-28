import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:tvseries/tvseries.dart';

class TvSeriesPopularNotifier extends ChangeNotifier {
  final GetPopularTvSeries getPopularTvSeries;

  TvSeriesPopularNotifier(this.getPopularTvSeries);

  RequestState _state = RequestState.HasEmpty;
  RequestState get state => _state;

  List<TvSeries> _tv = [];
  List<TvSeries> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.HasError;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}