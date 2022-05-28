import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchNotifier({required this.searchTvSeries});

  RequestState _state = RequestState.HasEmpty;
  RequestState get state => _state;

  List<TvSeries> _searchTvSeriesResult = [];
  List<TvSeries> get searchTvResult => _searchTvSeriesResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.HasError;
        notifyListeners();
      },
      (data) {
        _searchTvSeriesResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}