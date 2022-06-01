import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMoviesPopularBloc
    extends MockBloc<MoviesPopularEvent, MoviesPopularState>
    implements MoviesPopularBloc {}

class FakeMoviesPopularEvent extends Fake implements MoviesPopularEvent {}

class FakeMoviesPopularState extends Fake implements MoviesPopularState {}

void main() {
  late MockMoviesPopularBloc mockMoviesPopularBloc;

  setUp(() {
    mockMoviesPopularBloc = MockMoviesPopularBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeMoviesPopularEvent());
    registerFallbackValue(FakeMoviesPopularState());
  });

  tearDown(() {
    mockMoviesPopularBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviesPopularBloc>(
      create: (_) => mockMoviesPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {

    when(() => mockMoviesPopularBloc.state).thenReturn(MoviesPopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockMoviesPopularBloc.state)
        .thenReturn(MoviesPopularHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {

    when(() => mockMoviesPopularBloc.state).thenReturn(const MoviesPopularHasError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
