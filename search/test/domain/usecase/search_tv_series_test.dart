import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

import '../../helpers/helper_test.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTvSeries(mockTvRepository);
  });

  final tTvs = <TvSeries>[];
  const tQuery = 'Game of throne';

  test('should get list of tv from the repository', () async {

    // arrange
    when(mockTvRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTvs));

    // act
    final result = await usecase.execute(tQuery);

    // assert
    expect(result, Right(tTvs));
  });
}
