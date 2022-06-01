import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tvseries_popular_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late TvsPopularBloc tvsPopularBloc;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    tvsPopularBloc = TvsPopularBloc(mockGetPopularTvSeries);
  });

  test('initial state should be empty on TvsPopularBloc', () {
    expect(tvsPopularBloc.state, TvsPopularEmpty());
  });

  blocTest<TvsPopularBloc, TvsPopularState>(
    'Should emit [Loading, HasData] when tv series popular is successful',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvsPopularBloc;
    },
    act: (bloc) => bloc.add(TvsGetPopularEvent()),
    expect: () => [TvsPopularLoading(), TvsPopularHasData(testTvList)],
    verify: (bloc) {
      verify(
        mockGetPopularTvSeries.execute(),
      );
    },
  );

  blocTest<TvsPopularBloc, TvsPopularState>(
    'Should emit [Loading, HasError] when tv series popular is unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvsPopularBloc;
    },
    act: (bloc) => bloc.add(TvsGetPopularEvent()),
    expect: () => [
      TvsPopularLoading(),
      const TvsPopularHasError('Server Failure'),
    ],
    verify: (bloc) {
      verify(
        mockGetPopularTvSeries.execute(),
      );
    },
  );
}
