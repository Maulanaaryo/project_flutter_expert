import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MoviesRecommendationBloc moviesRecommendationBloc;

  const tId = 1;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    moviesRecommendationBloc =
        MoviesRecommendationBloc(mockGetMovieRecommendations);
  });

  test('initial state should be empty on MoviesRecommendationBloc', () {
    expect(moviesRecommendationBloc.state, MoviesRecommendationEmpty());
  });

  blocTest<MoviesRecommendationBloc, MoviesRecommendationState>(
    'Should emit [Loading, HasData] when movie recommendation is successful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));
      return moviesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const MoviesGetIdRecommendationEvent(tId)),
    expect: () => [
      MoviesRecommendationLoading(),
      MoviesRecommendationHasData(testMovieList)
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MoviesRecommendationBloc, MoviesRecommendationState>(
    'Should emit [Loading, HasError] when movie recommendation is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const MoviesGetIdRecommendationEvent(tId)),
    expect: () => [
      MoviesRecommendationLoading(),
      const MoviesRecommendationHasError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );
}
