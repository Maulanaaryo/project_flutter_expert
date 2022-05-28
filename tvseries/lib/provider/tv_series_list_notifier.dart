import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/tvseries.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTv = <TvSeries>[];
  List<TvSeries> get nowPlayingTv => _nowPlayingTv;

  RequestState _nowPlayingTvState = RequestState.HasEmpty;
  RequestState get nowPlayingTvState => _nowPlayingTvState;

  var _popularTv = <TvSeries>[];
  List<TvSeries> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.HasEmpty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <TvSeries>[];
  List<TvSeries> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.HasEmpty;
  RequestState get topRatedTvState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries
  });

  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  Future<void> fetchNowPlayingTvSeries() async {
    _nowPlayingTvState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingTvState = RequestState.HasError;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _nowPlayingTvState = RequestState.Loaded;
        _nowPlayingTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.HasError;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) {
        _topRatedTvState = RequestState.HasError;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTvState = RequestState.Loaded;
        _topRatedTv = tvData;
        notifyListeners();
      },
    );
  }
}
