import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tvseries_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TvsTopRatedBloc tvsTopRatedBloc;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvsTopRatedBloc = TvsTopRatedBloc(mockGetTopRatedTvSeries);
  });

  test('initial state state should be empty on MoviesTopRatedBloc', () {
    expect(tvsTopRatedBloc.state, TvsTopRatedEmpty());
  });

  blocTest<TvsTopRatedBloc, TvsTopRatedState>(
    'Should emit [Loading, HasData] when tv series top rated is successful',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvsTopRatedBloc;
    },
    act: (bloc) => bloc.add(TvsGetTopRatedEvent()),
    expect: () => [
      TvsTopRatedLoading(),
      TvsTopRatedHasData(testTvList),
    ],
    verify: (bloc) {
      verify(
        mockGetTopRatedTvSeries.execute(),
      );
    },
  );

  blocTest<TvsTopRatedBloc, TvsTopRatedState>(
    'Should emit [Loading, HasError] when tv series top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvsTopRatedBloc;
    },
    act: (bloc) => bloc.add(TvsGetTopRatedEvent()),
    expect: () => [
      TvsTopRatedLoading(),
      const TvsTopRatedHasError('Server Failure'),
    ],
    verify: (bloc) {
      verify(
        mockGetTopRatedTvSeries.execute(),
      );
    },
  );
}
