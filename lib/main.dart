import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinnings.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Bloc Movie
        BlocProvider(
          create: (_) => di.locator<MoviesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesWatchlistBloc>(),
        ),

        // Bloc Tvseries
        BlocProvider(
          create: (_) => di.locator<TvsSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvsDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvsOnAirBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvsPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvsRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvsTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvsWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: SplashScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            // movie
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );

            // tv series
            case '/tv-home-series':
              return MaterialPageRoute(builder: (_) => TvSeriesHomePage());
            case TvSeriesPopularPage.routeName:
              return CupertinoPageRoute(builder: (_) => TvSeriesPopularPage());
            case TvSeriesTopRatedPage.routeName:
              return CupertinoPageRoute(builder: (_) => TvSeriesTopRatedPage());
            case TvSeriesDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case TvSeriesSearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => TvSeriesSearchPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case TvSeriesWatchlistPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => TvSeriesWatchlistPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case SplashScreen.routeName:
              return MaterialPageRoute(builder: (_) => SplashScreen());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
