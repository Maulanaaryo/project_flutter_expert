import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';
import 'package:http/http.dart' as http;
import 'package:tvseries/tvseries.dart';

@GenerateMocks([
  MovieRepository,
  TvRepository,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}