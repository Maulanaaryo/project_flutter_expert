import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

class TvSeriesTopRatedPage extends StatefulWidget {
  static const routeName = '/top-rated-tv-series';

  const TvSeriesTopRatedPage({Key? key}) : super(key: key);

  @override
  _TvSeriesTopRatedPageState createState() => _TvSeriesTopRatedPageState();
}

class _TvSeriesTopRatedPageState extends State<TvSeriesTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvsTopRatedBloc>().add(TvsGetTopRatedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvsTopRatedBloc, TvsTopRatedState>(
          builder: (context, state) {
            if (state is TvsTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvsTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = state.tvSeries[index];
                  return TvSeriesCard(tvs);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is TvsTopRatedHasError) {
              return Center(
                child: Text(
                  state.message,
                  key: const Key('error_message'),
                ),
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('There is an error'),
              );
            }
          },
        ),
      ),
    );
  }
}
