import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

class MockTvsPopularBloc extends MockBloc<TvsPopularEvent,TvsPopularState> implements TvsPopularBloc {}
class FakeTvsTopRatedEvent extends Fake implements TvsPopularEvent {}
class FakeTvsTopRatedState extends Fake implements TvsPopularState {}

void main() {
  late MockTvsPopularBloc mockTvsPopularBloc;

  setUp(() {
    mockTvsPopularBloc = MockTvsPopularBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeTvsTopRatedEvent());
    registerFallbackValue(FakeTvsTopRatedState());
  });

  tearDown(() {
    mockTvsPopularBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvsPopularBloc>(create: (_) => mockTvsPopularBloc, child: MaterialApp(home: body,),);
  }
  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockTvsPopularBloc.state).thenReturn(TvsPopularLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(const TvSeriesPopularPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is HasData',
          (WidgetTester tester) async {
        when(() => mockTvsPopularBloc.state).thenReturn(const TvsPopularHasData(<TvSeries>[]));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(const TvSeriesPopularPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when HasError',
          (WidgetTester tester) async {
        when(() => mockTvsPopularBloc.state).thenReturn(const TvsPopularHasError('Error Message'));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(const TvSeriesPopularPage()));

        expect(textFinder, findsOneWidget);
      });
}