import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:tvseries/tvseries.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetDetailTvSeries getDetailTvSeries;
  final GetRecommendationsTvSeries getRecommendationsTvSeries;
  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  TvSeriesDetailNotifier({
    required this.getDetailTvSeries,
    required this.getRecommendationsTvSeries,
    required this.getWatchListStatusTvSeries,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
  });

  late TvSeriesDetail _tv;
  TvSeriesDetail get tv => _tv;

  RequestState _tvState = RequestState.HasEmpty;
  RequestState get tvState => _tvState;

  List<TvSeries> _tvRecommendations = [];
  List<TvSeries> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationTvState = RequestState.HasEmpty;
  RequestState get recommendationTvState => _recommendationTvState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistTv = false;
  bool get isAddedToWatchlistTv => _isAddedtoWatchlistTv;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getDetailTvSeries.execute(id);
    final recommendationResult = await getRecommendationsTvSeries.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = RequestState.HasError;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationTvState = RequestState.Loading;
        _tv = tv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationTvState = RequestState.HasError;
            _message = failure.message;
          },
          (tv) {
            _recommendationTvState = RequestState.Loaded;
            _tvRecommendations = tv;
          },
        );
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessageTv = '';
  String get watchlistMessageTv => _watchlistMessageTv;

  Future<void> addWatchlistTv(TvSeriesDetail tv) async {
    final result = await saveWatchlistTvSeries.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessageTv = failure.message;
      },
      (successMessage) async {
        _watchlistMessageTv = successMessage;
      },
    );

    await loadWatchlistStatusTv(tv.id);
  }

  Future<void> removeFromWatchlistTv(TvSeriesDetail tv) async {
    final result = await removeWatchlistTvSeries.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessageTv = failure.message;
      },
      (successMessage) async {
        _watchlistMessageTv = successMessage;
      },
    );

    await loadWatchlistStatusTv(tv.id);
  }

  Future<void> loadWatchlistStatusTv(int id) async {
    final result = await getWatchListStatusTvSeries.execute(id);
    _isAddedtoWatchlistTv = result;
    notifyListeners();
  }
}