import 'package:about/about.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
  static const routeName = '/home';
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MoviesNowPlayingBloc>().add(MoviesGetNowPlayingEvent());
      context.read<MoviesPopularBloc>().add(MoviesGetPopularEvent());
      context.read<MoviesTopRatedBloc>().add(MoviesGetTopRatedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv'),
              onTap: () {
                Navigator.pushNamed(context, TvSeriesHomePage.routeName);
              },
            ),
                ListTile(
                  leading: const Icon(Icons.move_to_inbox_rounded),
                  title: const Text('All Watchlist Movie'),
                  onTap: () {
                    Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.how_to_vote_rounded),
                  title: const Text('All Watchlist Tv'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, TvSeriesWatchlistPage.routeName);
                  },
                ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing Movies',
                style: kHeading6,
              ),
              BlocBuilder<MoviesNowPlayingBloc, MoviesNowPlayingState>(
                  builder: (context, state) {
                if (state is MoviesNowPlayingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviesNowPlayingHasData) {
                  final result = state.movie;
                  return MovieList(result);
                } else if (state is MoviesNowPlayingHasError) {
                  return Center(
                    child: Text(
                      state.message,
                      key: const Key('error'),
                    ),
                  );
                } else {
                  return const Text('There is an error');
                }
              }),
              _buildSubHeading(
                title: 'Popular Movies',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              BlocBuilder<MoviesPopularBloc, MoviesPopularState>(
                  builder: (context, state) {
                if (state is MoviesPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviesPopularHasData) {
                  final result = state.movie;
                  return MovieList(result);
                } else if (state is MoviesPopularHasError) {
                  return Center(
                    child: Text(
                      state.message,
                      key: const Key('error'),
                    ),
                  );
                } else {
                  return const Text('There is an error');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated Movies',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<MoviesTopRatedBloc, MoviesTopRatedState>(
                  builder: (context, state) {
                if (state is MoviesTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviesTopRatedHasData) {
                  final result = state.movie;
                  return MovieList(result);
                } else if (state is MoviesTopRatedHasError) {
                  return Center(
                    child: Text(
                      state.message,
                      key: const Key('error'),
                    ),
                  );
                } else {
                  return const Text('There is an error');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
