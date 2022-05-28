library movie;

export 'data/datasource/database/database_helper.dart';

export 'data/datasource/movie_local_data_source.dart';
export 'data/datasource/movie_remote_data_source.dart';

export 'data/models/movie_detail_model.dart';
export 'data/models/movie_model.dart';
export 'data/models/movie_response.dart';
export 'data/models/movie_table.dart';

export 'data/repositories/movie_repository_impl.dart';

export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';

export 'domain/repositories/movie_repository.dart';

export 'domain/usecases/get_movie_detail.dart';
export 'domain/usecases/get_movie_recommendations.dart';
export 'domain/usecases/get_now_playing_movies.dart';
export 'domain/usecases/get_popular_movies.dart';
export 'domain/usecases/get_top_rated_movies.dart';
export 'domain/usecases/get_watchlist_movies.dart';
export 'domain/usecases/get_watchlist_status.dart';
export 'domain/usecases/remove_watchlist.dart';
export 'domain/usecases/save_watchlist.dart';

export 'pages/home_movie_page.dart';
export 'pages/movie_detail_page.dart';
export 'pages/popular_movies_page.dart';
export 'pages/top_rated_movies_page.dart';
export 'pages/watchlist_movies_page.dart';

export 'provider/movie_detail_notifier.dart';
export 'provider/movie_list_notifier.dart';
export 'provider/popular_movies_notifier.dart';
export 'provider/top_rated_movies_notifier.dart';
export 'provider/watchlist_movie_notifier.dart';

export 'widgets/movie_card_list.dart';
