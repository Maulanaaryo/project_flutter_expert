import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tvseries_detail_bloc_test.mocks.dart';

@GenerateMocks([GetDetailTvSeries])
void main() {

  late TvsDetailBloc tvsDetailBloc;
  late MockGetDetailTvSeries mockGetDetailTvSeries;

  const tTvsId = 1;

  setUp(() {
    mockGetDetailTvSeries = MockGetDetailTvSeries();
    tvsDetailBloc = TvsDetailBloc(mockGetDetailTvSeries);
  });

  test('initial state should be empty on TvsDetailBloc', () {
    expect(tvsDetailBloc.state, TvsDetailEmpty());
  });

  blocTest<TvsDetailBloc, TvsDetailState>(
    'Should emit [Loading, HasData] data successful',
    build: () {
      when(mockGetDetailTvSeries.execute(tTvsId)).thenAnswer(
        (_) async => Right(testTvDetail),
      );
      return tvsDetailBloc;
    },
    act: (bloc) => bloc.add(const TvsGetIdDetailEvent(tTvsId)),
    expect: () => [
      TvsDetailLoading(),
      TvsDetailHasData(testTvDetail),
    ],
    verify: (bloc) {
      verify(
        mockGetDetailTvSeries.execute(tTvsId),
      );
    },
  );

    blocTest<TvsDetailBloc, TvsDetailState>(
    'Should emit [Loading, HasError] data unsuccessful',
    build: () {
      when(mockGetDetailTvSeries.execute(tTvsId)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return tvsDetailBloc;
    },
    act: (bloc) => bloc.add(const TvsGetIdDetailEvent(tTvsId)),
    expect: () => [
      TvsDetailLoading(),
      const TvsDetailHasError('Server Failure'),
    ],
    verify: (bloc) {
      verify(
        mockGetDetailTvSeries.execute(tTvsId),
      );
    },
  );
}
