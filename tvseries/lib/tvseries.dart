library tvseries;

export 'data/datasource/database/database_helper_tvs.dart';

export 'data/datasource/tv_series_local_data_source.dart';
export 'data/datasource/tv_series_remote_data_source.dart';

export 'data/models/tv_series_detail_model.dart';
export 'data/models/tv_series_model.dart';
export 'data/models/tv_series_response.dart';
export 'data/models/tv_series_tabel.dart';

export 'data/repository/tv_series_repository_impl.dart';

export 'domain/entities/tv_series.dart';
export 'domain/entities/tv_series_detail.dart';

export 'domain/repositories/tv_series_repository.dart';

export 'domain/usecases/get_detail_tv_series.dart';
export 'domain/usecases/get_now_playing_tv_series.dart';
export 'domain/usecases/get_popular_tv_series.dart';
export 'domain/usecases/get_recommendations_tv_series.dart';
export 'domain/usecases/get_top_rated_tv_series.dart';
export 'domain/usecases/get_watchlist_status_tv_series.dart';
export 'domain/usecases/get_watchlist_tv_series.dart';
export 'domain/usecases/remove_watchlist_tv_series.dart';
export 'domain/usecases/save_watchlist_tv_series.dart';

export 'presentation/bloc/tvseries_detail/tvs_detail_bloc.dart';
export 'presentation/bloc/tvseries_on_air/tvs_on_air_bloc.dart';
export 'presentation/bloc/tvseries_popular/tvs_popular_bloc.dart';
export 'presentation/bloc/tvseries_recommendation/tvs_recommendation_bloc.dart';
export 'presentation/bloc/tvseries_top_rated/tvs_top_rated_bloc.dart';
export 'presentation/bloc/tvseries_watchlist/tvs_watchlist_bloc.dart';

export 'presentation/pages/tv_series_detail_page.dart';
export 'presentation/pages/tv_series_home_page.dart';
export 'presentation/pages/tv_series_popular_page.dart';
export 'presentation/pages/tv_series_top_rated_page.dart';
export 'presentation/pages/tv_series_watchlist_page.dart';

export 'widgets/tv_series_card_list.dart';