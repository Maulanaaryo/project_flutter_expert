import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    Future.microtask(() =>
        Provider.of<TvSeriesTopRatedNotifier>(context, listen: false)
            .fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvSeriesTopRatedNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = data.tv[index];
                  return TvSeriesCard(tvs);
                },
                itemCount: data.tv.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
