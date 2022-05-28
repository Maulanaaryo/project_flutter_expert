import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/tvseries.dart';

class TvSeriesPopularPage extends StatefulWidget {
  static const routeName = '/popular-tv-series';

  const TvSeriesPopularPage({Key? key}) : super(key: key);

  @override
  _TvSeriesPopularPageState createState() => _TvSeriesPopularPageState();
}

class _TvSeriesPopularPageState extends State<TvSeriesPopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvSeriesPopularNotifier>(context, listen: false)
            .fetchPopularTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvSeriesPopularNotifier>(
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
