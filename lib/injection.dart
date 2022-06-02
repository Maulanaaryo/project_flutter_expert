import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

final locator = GetIt.instance;

void init() {

  // Bloc Movie
  locator.registerFactory(
    () => MoviesSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // Bloc TvSeries
  locator.registerFactory(
    () => TvsSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvsDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvsOnAirBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvsPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvsRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvsTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvsWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetDetailTvSeries(locator()));
  locator.registerLazySingleton(() => GetRecommendationsTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  //repository tv
  locator.registerLazySingleton<TvRepository>(
    () => TvsRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data source tv
  locator.registerLazySingleton<TvsRemoteDataSource>(
      () => TvsRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvsLocalDataSource>(
      () => TvsLocalDataSourceImpl(databaseTvHelper: locator()));

  // helper movie
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  
  // helper tv
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinnings.client);
}
