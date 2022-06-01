import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tvseries_on_air_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late TvsOnAirBloc tvsOnAirBloc;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    tvsOnAirBloc = TvsOnAirBloc(mockGetNowPlayingTvSeries);
  });

  test('initial state should be empty on TvsOnAirBloc', () {
    expect(tvsOnAirBloc.state, TvsOnAirEmpty());
  });

  blocTest<TvsOnAirBloc, TvsOnAirState>(
    'Should emit [Loading, HasData] when tv series on air is successful',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvsOnAirBloc;
    },
    act: (bloc) => bloc.add(TvsGetOnAirEvent()),
    expect: () => [
      TvsOnAirLoading(),
      TvsOnAirHasData(testTvList),
    ],
    verify: (bloc) {
      verify(
        mockGetNowPlayingTvSeries.execute(),
      );
    },
  );

    blocTest<TvsOnAirBloc, TvsOnAirState>(
    'Should emit [Loading, HasError] when tv series on air is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvsOnAirBloc;
    },
    act: (bloc) => bloc.add(TvsGetOnAirEvent()),
    expect: () => [
      TvsOnAirLoading(),
      const TvsOnAirHasError('Server Failure'),
    ],
    verify: (bloc) {
      verify(
        mockGetNowPlayingTvSeries.execute(),
      );
    },
  );
}
