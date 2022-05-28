import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tvseries/tvseries.dart';

@GenerateMocks([
  TvRepository,
  TvsRemoteDataSource,
  TvsLocalDataSource,
  TvDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}