import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tvseries/tvseries.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const routeName = '/detail-tv-series';

  final int id;
  const TvSeriesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvsDetailBloc>().add(TvsGetIdDetailEvent(widget.id));
      context
          .read<TvsRecommendationBloc>()
          .add(TvsGetIdRecommendationEvent(widget.id));
      context
          .read<TvsWatchlistBloc>()
          .add(TvsGetIdWatchlistStatusEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    TvsRecommendationState tvsRecommendationState =
        context.watch<TvsRecommendationBloc>().state;
    return Scaffold(
      body: BlocListener<TvsWatchlistBloc, TvsWatchlistState>(listener: (_, state) {
        if (state is TvsWatchlistSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),),);
          context.read<TvsWatchlistBloc>().add(TvsGetIdWatchlistStatusEvent(widget.id));
        }
      },
      child: BlocBuilder<TvsDetailBloc, TvsDetailState>(
        builder: (context, state) {
          if (state is TvsDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvsDetailHasData) {
            final tv = state.tvsDetail;
            bool isAddedToWatchlistTv = (context.watch<TvsWatchlistBloc>().state
                    is TvsWatchlistHasStatus)
                ? (context.read<TvsWatchlistBloc>().state
                        as TvsWatchlistHasStatus)
                    .status
                : false;
            return SafeArea(
              child: DetailContent(
                tv,
                tvsRecommendationState is TvsRecommendationHasData
                    ? tvsRecommendationState.tvSeries
                    : List.empty(),
                isAddedToWatchlistTv,
              ),
            );
          } else if (state is TvsDetailHasError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Data not found'),
            );
          }
        },
      ),
    ),);
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tv;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlistTv;

  const DetailContent(this.tv, this.recommendations, this.isAddedWatchlistTv, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlistTv) {
                                  BlocProvider.of<TvsWatchlistBloc>(
                                          context).add(TvsAddWatchlistEvent(tv));
                                } else {
                                  BlocProvider.of<TvsWatchlistBloc>(context).add(TvsRemoveWatchlistEvent(tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlistTv
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Text(
                              (tv.firstAirDate),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvsRecommendationBloc, TvsRecommendationState>(
                              builder: (context, state) {
                                if (state is TvsRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvsRecommendationHasError) {
                                  return Text(state.message);
                                } else if (state is TvsRecommendationHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvSeriesDetailPage.routeName,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
