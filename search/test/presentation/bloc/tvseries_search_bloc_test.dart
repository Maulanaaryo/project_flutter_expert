import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

import 'tvseries_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvsSearchBloc tvsSearchBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    tvsSearchBloc = TvsSearchBloc(mockSearchTvSeries);
  });

  test('initial state should be empty', () {
    expect(tvsSearchBloc.state, TvsSearchEmpty());
  });

  final testTvModel = TvSeries(
      backdropPath: '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
      genreIds: const [10765, 18, 10759, 9648],
      id: 1399,
      originalName: 'Game of Thrones',
      overview:
          "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
      popularity: 369.594,
      posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
      firstAirDate: '2011-04-17',
      name: 'Game of Thrones',
      voteAverage: 8.3,
      voteCount: 11504);

  final tTvsList = <TvSeries>[testTvModel];

  const tTvQuery = 'Game Of Thrones';

  blocTest<TvsSearchBloc, TvsSearchState>(
      'Should emit [Loading, HasData] data successful',
      build: () {
        when(mockSearchTvSeries.execute(tTvQuery))
            .thenAnswer((_) async => Right(tTvsList));
        return tvsSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChangedTv(tTvQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            TvsSearchLoading(),
            TvsSearchHasData(tTvsList),
          ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tTvQuery));
      });

  blocTest<TvsSearchBloc, TvsSearchState>(
      'Should emit [Loading, HasError] data unsuccessful',
      build: () {
        when(mockSearchTvSeries.execute(tTvQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvsSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChangedTv(tTvQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            TvsSearchLoading(),
            const TvsSearchHasError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tTvQuery));
      });
}