import 'package:ditonton/data/models/tv_series/tv_series_tabel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperTv {
  static DatabaseHelperTv? _databaseHelpertv;
  DatabaseHelperTv._instance() {
    _databaseHelpertv = this;
  }

  factory DatabaseHelperTv() =>
      _databaseHelpertv ?? DatabaseHelperTv._instance();

  static Database? _databasetv;

  Future<Database?> get databasetv async {
    if (_databasetv == null) {
      _databasetv = await _initDb();
    }
    return _databasetv;
  }

  static const String _tblWatchlisttv = 'watchlisttv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditontontv.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblWatchlisttv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistTv(TvTable tv) async {
    final db = await databasetv;
    return await db!.insert(_tblWatchlisttv, tv.toJson());
  }

  Future<int> removeWatchlistTv(TvTable tv) async {
    final db = await databasetv;
    return await db!.delete(
      _tblWatchlisttv,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await databasetv;
    final results = await db!.query(
      _tblWatchlisttv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await databasetv;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlisttv);

    return results;
  }
}
