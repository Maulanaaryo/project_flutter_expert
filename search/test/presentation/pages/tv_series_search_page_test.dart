import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

class MockTvsSearchBloc extends MockBloc<TvsSearchEvent, TvsSearchState>
    implements TvsSearchBloc {}

class FakeTvsSearchEvent extends Fake implements TvsSearchEvent {}

class FakeTvsSearchState extends Fake implements TvsSearchState {}

void main() {
  late MockTvsSearchBloc mockTvsSearchBloc;

  setUp(() {
    mockTvsSearchBloc = MockTvsSearchBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeTvsSearchEvent());
    registerFallbackValue(FakeTvsSearchState());
  });

  tearDown(() {
    mockTvsSearchBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvsSearchBloc>(
      create: (_) => mockTvsSearchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => mockTvsSearchBloc.state).thenReturn(const TvsSearchHasData(<TvSeries>[]));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(const TvSeriesSearchPage()));

        expect(listViewFinder, findsOneWidget);
      });
}
