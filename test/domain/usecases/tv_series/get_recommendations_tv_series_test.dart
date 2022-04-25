import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_recommendations_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_tv_series_helper.mocks.dart';

void main() {
  late GetRecommendationsTvSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetRecommendationsTvSeries(mockTvRepository);
  });

  final tId = 1;
  final tTv = <TvSeries>[];

  test('should get list of tv recommendations from the repository',
      () async {
    // arrange
    when(mockTvRepository.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTv));
  });
}
