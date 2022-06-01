import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MoviesPopularBloc moviesPopularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviesPopularBloc = MoviesPopularBloc(mockGetPopularMovies);
  });

  test('initial state should be empty on MoviesPopularBloc', () {
    expect(moviesPopularBloc.state, MoviesPopularEmpty());
  });

  blocTest<MoviesPopularBloc, MoviesPopularState>(
    'Should emit [Loading, HasData] when movie popular is successful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return moviesPopularBloc;
    },
    act: (bloc) => bloc.add(MoviesGetPopularEvent()),
    expect: () => [MoviesPopularLoading(), MoviesPopularHasData(testMovieList)],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MoviesPopularBloc, MoviesPopularState>(
    'Should emit [Loading, HasError] when movie popular is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviesPopularBloc;
    },
    act: (bloc) => bloc.add(MoviesGetPopularEvent()),
    expect: () =>
        [MoviesPopularLoading(), const MoviesPopularHasError('Server Failure')],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
