import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MoviesNowPlayingBloc moviesNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    moviesNowPlayingBloc = MoviesNowPlayingBloc(mockGetNowPlayingMovies);
  });

  test('initial state should be empty on MoviesNowPlayingBloc', () {
    expect(moviesNowPlayingBloc.state, MoviesNowPlayingEmpty());
  });

  blocTest<MoviesNowPlayingBloc, MoviesNowPlayingState>(
    'Should emit [Loading, HasData] when movie now playing is successful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return moviesNowPlayingBloc;
    },
    act: (bloc) => bloc.add(MoviesGetNowPlayingEvent()),
    expect: () =>
        [MoviesNowPlayingLoading(), MoviesNowPlayingHasData(testMovieList)],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MoviesNowPlayingBloc, MoviesNowPlayingState>(
    'Should emit [Loading, HasError] when movie now playing is unsucessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviesNowPlayingBloc;
    },
    act: (bloc) => bloc.add(MoviesGetNowPlayingEvent()),
    expect: () => [
      MoviesNowPlayingLoading(),
      const MoviesNowPlayingHasError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
