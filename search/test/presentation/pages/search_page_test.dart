import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';

class MockMoviesSearchBloc
    extends MockBloc<MoviesSearchEvent, MoviesSearchState>
    implements MoviesSearchBloc {}

class FakeMoviesSearchEvent extends Fake implements MoviesSearchEvent {}

class FakeMoviesSearchState extends Fake implements MoviesSearchState {}

void main() {
  late MockMoviesSearchBloc mockMoviesSearchBloc;

  setUp(() {
    mockMoviesSearchBloc = MockMoviesSearchBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeMoviesSearchEvent());
    registerFallbackValue(FakeMoviesSearchState());
  });

  tearDown(() {
    mockMoviesSearchBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviesSearchBloc>(
      create: (_) => mockMoviesSearchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockMoviesSearchBloc.state)
        .thenReturn(const MoviesSearchHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
