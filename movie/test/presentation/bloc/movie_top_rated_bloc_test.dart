import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MoviesTopRatedBloc moviesTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    moviesTopRatedBloc = MoviesTopRatedBloc(mockGetTopRatedMovies);
  });

  test('initial state state should be empty on MoviesTopRatedBloc', () {
    expect(moviesTopRatedBloc.state, MoviesTopRatedEmpty());
  });

  blocTest<MoviesTopRatedBloc, MoviesTopRatedState>(
    'Should emit [Loading, HasData] when movie top rated is successful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return moviesTopRatedBloc;
    },
    act: (bloc) => bloc.add(MoviesGetTopRatedEvent()),
    expect: () =>
        [MoviesTopRatedLoading(), MoviesTopRatedHasData(testMovieList)],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<MoviesTopRatedBloc, MoviesTopRatedState>(
    'Should emit [Loading, HasError] when movie top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviesTopRatedBloc;
    },
    act: (bloc) => bloc.add(MoviesGetTopRatedEvent()),
    expect: () => [
      MoviesTopRatedLoading(),
      const MoviesTopRatedHasError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
