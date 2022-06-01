import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MoviesDetailBloc moviesDetailBloc;

  const tMovieId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    moviesDetailBloc = MoviesDetailBloc(mockGetMovieDetail);
  });

  test('initial state should be empty on MoviesDetailBloc', () {
    expect(moviesDetailBloc.state, MoviesDetailEmpty());
  });

  blocTest<MoviesDetailBloc, MoviesDetailState>(
    'Should emit [Loading, HasData] data successful',
    build: () {
      when(mockGetMovieDetail.execute(tMovieId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return moviesDetailBloc;
    },
    act: (bloc) => bloc.add(const MoviesGetIdDetailEvent(tMovieId)),
    expect: () => [MoviesDetailLoading(), MoviesDetailHasData(testMovieDetail)],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tMovieId));
    },
  );

  blocTest<MoviesDetailBloc, MoviesDetailState>(
    'Should emit [Loading, HasError] data unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tMovieId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviesDetailBloc;
    },
    act: (bloc) => bloc.add(const MoviesGetIdDetailEvent(tMovieId)),
    expect: () => [
      MoviesDetailLoading(),
      const MoviesDetailHasError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tMovieId));
    },
  );
}
