import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tvseries_recommendation_test.mocks.dart';

@GenerateMocks([GetRecommendationsTvSeries])
void main() {
  late MockGetRecommendationsTvSeries mockGetRecommendationsTvSeries;
  late TvsRecommendationBloc tvsRecommendationBloc;

  const tTvsId = 1;

  setUp(() {
    mockGetRecommendationsTvSeries = MockGetRecommendationsTvSeries();
    tvsRecommendationBloc =
        TvsRecommendationBloc(mockGetRecommendationsTvSeries);
  });

  test('initial state should be empty on TvsRecommendationBloc', () {
    expect(tvsRecommendationBloc.state, TvsRecommendationEmpty());
  });

  blocTest<TvsRecommendationBloc, TvsRecommendationState>(
    'Should emit [Loading, HasData] when tv series recommendation is successful',
    build: () {
      when(mockGetRecommendationsTvSeries.execute(tTvsId))
          .thenAnswer((_) async => Right(testTvList));
      return tvsRecommendationBloc;
    },
    act: (bloc) => bloc.add(const TvsGetIdRecommendationEvent(tTvsId)),
    expect: () => [
      TvsRecommendationLoading(),
      TvsRecommendationHasData(testTvList),
    ],
    verify: (bloc) {
      verify(
        mockGetRecommendationsTvSeries.execute(tTvsId),
      );
    },
  );

  blocTest<TvsRecommendationBloc, TvsRecommendationState>(
    'Should emit [Loading, HasError] when tv series recommendation is unsuccessful',
    build: () {
      when(mockGetRecommendationsTvSeries.execute(tTvsId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvsRecommendationBloc;
    },
    act: (bloc) => bloc.add(const TvsGetIdRecommendationEvent(tTvsId)),
    expect: () => [
      TvsRecommendationLoading(),
      const TvsRecommendationHasError('Server Failure'),
    ],
    verify: (bloc) {
      verify(
        mockGetRecommendationsTvSeries.execute(tTvsId),
      );
    },
  );
}
