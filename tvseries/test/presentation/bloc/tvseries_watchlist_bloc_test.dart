import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tvseries_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries
])
void main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late TvsWatchlistBloc tvsWatchlistBloc;

  const tTvsId = 1;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    tvsWatchlistBloc = TvsWatchlistBloc(
        mockGetWatchlistTvSeries,
        mockGetWatchListStatusTvSeries,
        mockSaveWatchlistTvSeries,
        mockRemoveWatchlistTvSeries);
  });

  test('initial state should be empty on all TvsWatchlistBloc', () {
    expect(tvsWatchlistBloc.state, TvsWatchlistEmpty());
  });

  blocTest<TvsWatchlistBloc, TvsWatchlistState>(
    'Should emit [Loading, HasData] when TvsWatchlist is successful',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      return tvsWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvsGetWatchlistEvent()),
    expect: () => [
      TvsWatchlistLoading(),
      TvsWatchlistHasList([testWatchlistTv]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
      return TvsGetWatchlistEvent().props;
    },
  );

  blocTest<TvsWatchlistBloc, TvsWatchlistState>(
    'Should emit [Loading, HasError] when TvsWatchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvsWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvsGetWatchlistEvent()),
    expect: () => [
      TvsWatchlistLoading(),
      const TvsWatchlistHasError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<TvsWatchlistBloc, TvsWatchlistState>(
    'Should emit [HasData] when TvsWatchlistStatus is successful',
    build: () {
      when(mockGetWatchListStatusTvSeries.execute(tTvsId))
          .thenAnswer((_) async => true);
      return tvsWatchlistBloc;
    },
    act: (bloc) => bloc.add(const TvsGetIdWatchlistStatusEvent(tTvsId)),
    expect: () => [ TvsWatchlistLoading(),
      const TvsWatchlistHasStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatusTvSeries.execute(tTvsId));
      return const TvsGetIdWatchlistStatusEvent(tTvsId).props;
    },
  );

  blocTest<TvsWatchlistBloc, TvsWatchlistState>(
    'Should emit [HasError] when TvsWatchlistStatus is unsuccessful',
    build: () {
      when(mockGetWatchListStatusTvSeries.execute(tTvsId))
          .thenAnswer((_) async => false);
      return tvsWatchlistBloc;
    },
    act: (bloc) => bloc.add(const TvsGetIdWatchlistStatusEvent(tTvsId)),
    expect: () => [ TvsWatchlistLoading(),
      const TvsWatchlistHasStatus(false),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatusTvSeries.execute(tTvsId));
      return const TvsGetIdWatchlistStatusEvent(tTvsId).props;
    },
  );

  blocTest<TvsWatchlistBloc, TvsWatchlistState>(
    'Should emit [AddData] when tv series add to watchlist is successful',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Success'));
      return tvsWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvsAddWatchlistEvent(testTvDetail)),
    expect: () => [
      const TvsWatchlistSuccess('Success'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testTvDetail));
      return TvsAddWatchlistEvent(testTvDetail).props;
    },
  );

  blocTest<TvsWatchlistBloc, TvsWatchlistState>(
    'Should emit [ErrorData] when tv series add to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('Failed to add')));
      return tvsWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvsAddWatchlistEvent(testTvDetail)),
    expect: () => [
      const TvsWatchlistHasError('Failed to add'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testTvDetail));
      return TvsAddWatchlistEvent(testTvDetail).props;
    },
  );

  blocTest<TvsWatchlistBloc, TvsWatchlistState>(
    'Should emit [Remove] when tv series remove from watchlist is successful',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Success Remove'));
      return tvsWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvsRemoveWatchlistEvent(testTvDetail)),
    expect: () => [
      const TvsWatchlistSuccess('Success Remove'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvSeries.execute(testTvDetail));
      return TvsRemoveWatchlistEvent(testTvDetail).props;
    },
  );

  blocTest<TvsWatchlistBloc, TvsWatchlistState>(
    'Should emit [RemoveError] when tv series remove from watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed to Remove')));
      return tvsWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvsRemoveWatchlistEvent(testTvDetail)),
    expect: () => [
      const TvsWatchlistHasError('Failed to Remove'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvSeries.execute(testTvDetail));
      return TvsRemoveWatchlistEvent(testTvDetail).props;
    },
  );
}
