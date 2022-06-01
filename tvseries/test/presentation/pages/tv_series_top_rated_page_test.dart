import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

class MockTvsTopRatedBloc extends MockBloc<TvsTopRatedEvent,TvsTopRatedState> implements TvsTopRatedBloc {}
class FakeTvsTopRatedEvent extends Fake implements TvsTopRatedEvent {}
class FakeTvsTopRatedState extends Fake implements TvsTopRatedState {}

void main() {
  late MockTvsTopRatedBloc mockTvsTopRatedBloc;

  setUp(() {
    mockTvsTopRatedBloc = MockTvsTopRatedBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeTvsTopRatedEvent());
    registerFallbackValue(FakeTvsTopRatedState());
  });

  tearDown(() {
    mockTvsTopRatedBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvsTopRatedBloc>(create: (_) => mockTvsTopRatedBloc, child: MaterialApp(home: body,),);
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockTvsTopRatedBloc.state).thenReturn(TvsTopRatedLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(const TvSeriesTopRatedPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is HasData',
          (WidgetTester tester) async {
        when(() => mockTvsTopRatedBloc.state).thenReturn(const TvsTopRatedHasData(<TvSeries>[]));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(const TvSeriesTopRatedPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when HasError',
          (WidgetTester tester) async {
        when(() => mockTvsTopRatedBloc.state).thenReturn(const TvsTopRatedHasError('Error Message'));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(const TvSeriesTopRatedPage()));

        expect(textFinder, findsOneWidget);
      });
}