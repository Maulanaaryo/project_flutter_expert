import 'dart:io';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';

class TvsRepositoryImpl implements TvRepository {
  final TvsLocalDataSource localDataSource;
  final TvsRemoteDataSource remoteDataSource;

  TvsRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries() async {
    try {
      final result = await remoteDataSource.getNowPlayingTvSeries();

      return Right(
        result.map((model) => model.toEntity()).toList(),
      );
    } on ServerException {
      return const Left(
        ServerFailure(''),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('Failed to connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvSeries();

      return Right(
        result.map((model) => model.toEntity()).toList(),
      );
    } on ServerException {
      return const Left(
        ServerFailure(''),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('Failed to connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTvSeries();

      return Right(
        result.map((model) => model.toEntity()).toList(),
      );
    } on ServerException {
      return const Left(
        ServerFailure(''),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('Failed to connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvSeriesDetail(id);

      return Right(
        result.toEntity(),
      );
    } on ServerException {
      return const Left(
        ServerFailure(''),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('Failed to connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTvSeriesRecommendations(id);

      return Right(
        result.map((model) => model.toEntity()).toList(),
      );
    } on ServerException {
      return const Left(
        ServerFailure(''),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('Failed to connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query);

      return Right(
        result.map((model) => model.toEntity()).toList(),
      );
    } on ServerException {
      return const Left(
        ServerFailure(''),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('Failed to connect to the network'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTvSeries(
      TvSeriesDetail tv) async {
    try {
      final result = await localDataSource.insertWatchlistTv(
        TvTable.fromEntity(tv),
      );

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(
        DatabaseFailure(e.message),
      );
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTvSeries(
      TvSeriesDetail tv) async {
    try {
      final result = await localDataSource.removeWatchlistTv(
        TvTable.fromEntity(tv),
      );

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(
        DatabaseFailure(e.message),
      );
    }
  }

  @override
  Future<bool> isAddedToWatchlistTvSeries(int id) async {
    final result = await localDataSource.getTvById(id);

    return result != null;
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries() async {
    final result = await localDataSource.getTvWatchlist();

    return Right(
      result.map((data) => data.toEntity()).toList(),
    );
  }
}
