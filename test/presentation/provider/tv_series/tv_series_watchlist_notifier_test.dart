import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'tv_series_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late TvSeriesWatchlistNotifier provider;
  late MockGetWatchlistTvSeries mockGetWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTv = MockGetWatchlistTvSeries();
    provider = TvSeriesWatchlistNotifier(
      getWatchlistTvSeries: mockGetWatchlistTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistTv.execute())
        .thenAnswer((_) async => Right([testWatchlistTv]));
    // act
    await provider.fetchWatchlistTv();
    // assert
    expect(provider.watchlistTvState, RequestState.Loaded);
    expect(provider.watchlistTv, [testWatchlistTv]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTv.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTv();
    // assert
    expect(provider.watchlistTvState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
