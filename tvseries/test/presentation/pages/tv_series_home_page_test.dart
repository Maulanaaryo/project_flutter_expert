import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects_tv.dart';

class MockTvsOnAirBloc extends MockBloc<TvsOnAirEvent, TvsOnAirState>
    implements TvsOnAirBloc {}

class FakeTvsOnAirEvent extends Fake implements TvsOnAirEvent {}

class FakeTvsOnAirState extends Fake implements TvsDetailState {}

class MockTvsPopularBloc extends MockBloc<TvsPopularEvent, TvsPopularState>
    implements TvsPopularBloc {}

class FakeTvsPopularEvent extends Fake implements TvsPopularEvent {}

class FakeTvsPopularState extends Fake implements TvsPopularState {}

class MockTvsTopRatedBloc extends MockBloc<TvsTopRatedEvent, TvsTopRatedState>
    implements TvsTopRatedBloc {}

class FakeTvsTopRatedEvent extends Fake implements TvsPopularEvent {}

class FakeTvsTopRatedState extends Fake implements TvsPopularState {}

void main() {
  late MockTvsOnAirBloc mockTvsOnAirBloc;
  late MockTvsPopularBloc mockTvsPopularBloc;
  late MockTvsTopRatedBloc mockTvsTopRatedBloc;

  setUp(() {
    mockTvsOnAirBloc = MockTvsOnAirBloc();
    mockTvsPopularBloc = MockTvsPopularBloc();
    mockTvsTopRatedBloc = MockTvsTopRatedBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeTvsOnAirEvent());
    registerFallbackValue(FakeTvsOnAirState());

    registerFallbackValue(FakeTvsPopularEvent());
    registerFallbackValue(FakeTvsPopularState());

    registerFallbackValue(FakeTvsTopRatedEvent());
    registerFallbackValue(FakeTvsTopRatedState());
  });

  tearDown(() {
    mockTvsOnAirBloc.close();
    mockTvsPopularBloc.close();
    mockTvsTopRatedBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvsOnAirBloc>(create: (_) => mockTvsOnAirBloc),
        BlocProvider<TvsPopularBloc>(create: (_) => mockTvsPopularBloc),
        BlocProvider<TvsTopRatedBloc>(create: (_) => mockTvsTopRatedBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvsOnAirBloc.state).thenReturn(TvsOnAirLoading());
    when(() => mockTvsPopularBloc.state).thenReturn(TvsPopularLoading());
    when(() => mockTvsTopRatedBloc.state).thenReturn(TvsTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesHomePage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets(
      'Page should display ListView On The Air Series, Popular Series and Top Rated Series when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvsOnAirBloc.state).thenReturn(TvsOnAirHasData(testTvList));
    when(() => mockTvsPopularBloc.state)
        .thenReturn(TvsPopularHasData(testTvList));
    when(() => mockTvsTopRatedBloc.state)
        .thenReturn(TvsTopRatedHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesHomePage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('page should display error with text when Error state is happen',
      (WidgetTester tester) async {
    when(() => mockTvsOnAirBloc.state)
        .thenReturn(const TvsOnAirHasError('error'));
    when(() => mockTvsPopularBloc.state)
        .thenReturn(const TvsPopularHasError('error'));
    when(() => mockTvsTopRatedBloc.state)
        .thenReturn(const TvsTopRatedHasError('error'));

    final errorKeyFinder = find.byKey(const Key('error'));

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesHomePage()));
    expect(errorKeyFinder, findsNWidgets(3));
  });
}
