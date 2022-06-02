import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    Future.microtask(() {
      context.read<TvsPopularBloc>().add(TvsGetPopularEvent());
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvsPopularBloc, TvsPopularState>(
          builder: (context, state) {
            if (state is TvsPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvsPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = state.tvSeries[index];
                  return TvSeriesCard(tvs);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is TvsPopularHasError) {
              return Center(
                child: Text(state.message, key: const Key('error_message'),),
              );
            }
            else {
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
