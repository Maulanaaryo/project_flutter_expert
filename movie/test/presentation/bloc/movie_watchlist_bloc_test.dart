import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistMovies, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MoviesWatchlistBloc moviesWatchlistBloc;

  const tId = 1;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    moviesWatchlistBloc = MoviesWatchlistBloc(mockGetWatchListStatus,
        mockGetWatchlistMovies, mockSaveWatchlist, mockRemoveWatchlist);
  });

  test('initial state should be empty on all MoviesWatchlistBloc', () {
    expect(moviesWatchlistBloc.state, MoviesWatchlistEmpty());
  });

  blocTest<MoviesWatchlistBloc, MoviesWatchlistState>(
    'Should emit [Loading, HasData] when MovieWatchlist is successful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return moviesWatchlistBloc;
    },
    act: (bloc) => bloc.add(MoviesGetWathclistEvent()),
    expect: () => [
      MoviesWatchlistLoading(),
      MoviesWatchlistHasList([testWatchlistMovie]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
      return MoviesGetWathclistEvent().props;
    },
  );

  blocTest<MoviesWatchlistBloc, MoviesWatchlistState>(
    'Should emit [Loading, HasError] when MovieWatchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviesWatchlistBloc;
    },
    act: (bloc) => bloc.add(MoviesGetWathclistEvent()),
    expect: () => [
      MoviesWatchlistLoading(),
      const MoviesWatchlistHasError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
      return MoviesGetWathclistEvent().props;
    },
  );

  blocTest<MoviesWatchlistBloc, MoviesWatchlistState>(
    'Should emit [HasData] when MovieWatchlistStatus is successful',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return moviesWatchlistBloc;
    },
    act: (bloc) => bloc.add(const MoviesWatchlistStatusEvent(tId)),
    expect: () =>
        [MoviesWatchlistLoading(), const MoviesWatchlistHasStatus(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
      return const MoviesWatchlistStatusEvent(tId).props;
    },
  );

  blocTest<MoviesWatchlistBloc, MoviesWatchlistState>(
    'Should emit [HasError] when MovieWatchlistStatus is unsuccessful',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => false);
      return moviesWatchlistBloc;
    },
    act: (bloc) => bloc.add(const MoviesWatchlistStatusEvent(tId)),
    expect: () =>
        [MoviesWatchlistLoading(), const MoviesWatchlistHasStatus(false)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
      return const MoviesWatchlistStatusEvent(tId).props;
    },
  );

  blocTest<MoviesWatchlistBloc, MoviesWatchlistState>(
    'Should emit [AddData] when movie add to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('successfully added'));
      return moviesWatchlistBloc;
    },
    act: (bloc) => bloc.add(MoviesAddWatchlistEvent(testMovieDetail)),
    expect: () => [
      const MoviesWatchlistSuccess('successfully added'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
      return MoviesAddWatchlistEvent(testMovieDetail).props;
    },
  );

  blocTest<MoviesWatchlistBloc, MoviesWatchlistState>(
    'Should emit [ErrorData] when movie add to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('not successfully added')));
      return moviesWatchlistBloc;
    },
    act: (bloc) => bloc.add(MoviesAddWatchlistEvent(testMovieDetail)),
    expect: () => [
      const MoviesWatchlistHasError('not successfully added'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
      return MoviesAddWatchlistEvent(testMovieDetail).props;
    },
  );

  blocTest<MoviesWatchlistBloc, MoviesWatchlistState>(
    'Should emit [Remove] when movie remove from watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('successfully remove'));
      return moviesWatchlistBloc;
    },
    act: (bloc) => bloc.add(MoviesRemoveWatchlistEvent(testMovieDetail)),
    expect: () => [
      const MoviesWatchlistSuccess('successfully remove'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
      return MoviesRemoveWatchlistEvent(testMovieDetail).props;
    },
  );

  blocTest<MoviesWatchlistBloc, MoviesWatchlistState>(
    'Should emit [RemoveError] when movie remove from watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('failed remove')));
      return moviesWatchlistBloc;
    },
    act: (bloc) => bloc.add(MoviesRemoveWatchlistEvent(testMovieDetail)),
    expect: () => [
      const MoviesWatchlistHasError('failed remove'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
      return MoviesRemoveWatchlistEvent(testMovieDetail).props;
    },
  );
}
