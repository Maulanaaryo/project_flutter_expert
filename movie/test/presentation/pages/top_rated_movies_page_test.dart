import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMoviesTopRatedBloc extends MockBloc<MoviesTopRatedEvent, MoviesTopRatedState> implements MoviesTopRatedBloc {}
class FakeMoviesTopRatedEvent extends Fake implements MoviesTopRatedEvent {}
class FakeMoviesTopRatedState extends Fake implements MoviesTopRatedState {}

void main() {
  late MockMoviesTopRatedBloc mockMoviesTopRatedBloc;

  setUp(() {
    mockMoviesTopRatedBloc = MockMoviesTopRatedBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeMoviesTopRatedEvent());
    registerFallbackValue(FakeMoviesTopRatedState());
  });

  tearDown(() {
    mockMoviesTopRatedBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviesTopRatedBloc>(
      create: (_) => mockMoviesTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
        
    when(() => mockMoviesTopRatedBloc.state)
        .thenReturn(MoviesTopRatedLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {

    when(() => mockMoviesTopRatedBloc.state).thenReturn(MoviesTopRatedHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {

    when(() => mockMoviesTopRatedBloc.state).thenReturn(const MoviesTopRatedHasError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
