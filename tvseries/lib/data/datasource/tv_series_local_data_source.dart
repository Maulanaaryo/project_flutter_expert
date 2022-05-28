import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';

abstract class TvsLocalDataSource {

  Future<String> insertWatchlistTv(TvTable tv);
  Future<String> removeWatchlistTv(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getTvWatchlist();
}

class TvsLocalDataSourceImpl implements TvsLocalDataSource {
  final TvDatabaseHelper databaseTvHelper;

  TvsLocalDataSourceImpl({required this.databaseTvHelper});

  @override
  Future<String> insertWatchlistTv(TvTable tv) async {
    try {
      await databaseTvHelper.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    }
    catch (e) {
      throw DatabaseException(e.toString(),
      );
    }
  }

  @override 
  Future<String> removeWatchlistTv(TvTable tv) async {
    try {
      await databaseTvHelper.removeWatchlistTv(tv);
      return 'Removed from watchlist';
    }
    catch (e) {
      throw DatabaseException(e.toString(),
      );
    }
  }

  @override 
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseTvHelper.getTvById(id);

    if(result != null) {
      return TvTable.fromMap(result);
    }
    else {
      return null;
    }
  }

  @override 
  Future<List<TvTable>> getTvWatchlist() async {
    final result = await databaseTvHelper.getTvWatchlist();

    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}