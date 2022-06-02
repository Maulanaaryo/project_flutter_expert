import 'package:about/about.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

class TvSeriesHomePage extends StatefulWidget {
  static const routeName = '/tv-home-series';

  const TvSeriesHomePage({Key? key}) : super(key: key);

  @override
  _TvSeriesHomePageState createState() => _TvSeriesHomePageState();
}

class _TvSeriesHomePageState extends State<TvSeriesHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvsOnAirBloc>().add(TvsGetOnAirEvent());
      context.read<TvsPopularBloc>().add(TvsGetPopularEvent());
      context.read<TvsTopRatedBloc>().add(TvsGetTopRatedEvent());
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
                Navigator.pushNamed(context, HomeMoviePage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv'),
              onTap: () {
                Navigator.pop(context);
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
                Navigator.pushNamed(context, TvSeriesWatchlistPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TvSeriesSearchPage.routeName);
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
                'Now Playing Tv',
                style: kHeading6,
              ),
              BlocBuilder<TvsOnAirBloc, TvsOnAirState>(
                  builder: (context, state) {
                if (state is TvsOnAirLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvsOnAirHasData) {
                  return TvList(state.tvSeries);
                } else if (state is TvsOnAirHasError) {
                  return Text(
                    state.message,
                    key: const Key('error'),
                  );
                } else {
                  return const Text('There is an error');
                }
              }),
              _buildSubHeading(
                title: 'Popular Tv',
                onTap: () =>
                    Navigator.pushNamed(context, TvSeriesPopularPage.routeName),
              ),
              BlocBuilder<TvsPopularBloc, TvsPopularState>(
                  builder: (context, state) {
                if (state is TvsPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvsPopularHasData) {
                  final result = state.tvSeries;
                  return TvList(result);
                } else if (state is TvsPopularHasError) {
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
                title: 'Top Rated Tv',
                onTap: () => Navigator.pushNamed(
                    context, TvSeriesTopRatedPage.routeName),
              ),
              BlocBuilder<TvsTopRatedBloc, TvsTopRatedState>(
                  builder: (context, state) {
                if (state is TvsTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvsTopRatedHasData) {
                  final result = state.tvSeries;
                  return TvList(result);
                } else if (state is TvsTopRatedHasError) {
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

class TvList extends StatelessWidget {
  final List<TvSeries> tv;

  const TvList(this.tv, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvs = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.routeName,
                  arguments: tvs.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvs.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
