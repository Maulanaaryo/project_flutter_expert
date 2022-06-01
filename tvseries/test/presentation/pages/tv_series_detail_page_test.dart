import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects_tv.dart';

class MockTvsDetailBloc extends MockBloc<TvsDetailEvent, TvsDetailState>
    implements TvsDetailBloc {}

class FakeTvsDetailEvent extends Fake implements TvsDetailEvent {}

class FakeTvsDetailState extends Fake implements TvsDetailState {}

class MockTvsRecommendationBloc
    extends MockBloc<TvsRecommendationEvent, TvsRecommendationState>
    implements TvsRecommendationBloc {}

class FakeTvsRecommendationEvent extends Fake
    implements TvsRecommendationEvent {}

class FakeTvsRecommendationState extends Fake
    implements TvsRecommendationState {}

class MockTvsWatchlistBloc
    extends MockBloc<TvsWatchlistEvent, TvsWatchlistState>
    implements TvsWatchlistBloc {}

class FakeTvsWatchlistEvent extends Fake implements TvsWatchlistEvent {}

class FakeTvsWatchlistState extends Fake implements TvsWatchlistState {}

void main() {
  late MockTvsDetailBloc mockTvsDetailBloc;
  late MockTvsRecommendationBloc mockTvsRecomendationBloc;
  late MockTvsWatchlistBloc mockTvsWatchlistBloc;

  setUp(() {
    mockTvsDetailBloc = MockTvsDetailBloc();
    mockTvsRecomendationBloc = MockTvsRecommendationBloc();
    mockTvsWatchlistBloc = MockTvsWatchlistBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeTvsDetailEvent());
    registerFallbackValue(FakeTvsDetailState());

    registerFallbackValue(FakeTvsRecommendationEvent());
    registerFallbackValue(FakeTvsRecommendationState());

    registerFallbackValue(FakeTvsWatchlistEvent());
    registerFallbackValue(FakeTvsWatchlistState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TvsDetailBloc>(create: (_) => mockTvsDetailBloc),
        BlocProvider<TvsRecommendationBloc>(
            create: (_) => mockTvsRecomendationBloc),
        BlocProvider<TvsWatchlistBloc>(create: (_) => mockTvsWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when series not added to watchlist',
          (WidgetTester tester) async {
        when(() => mockTvsDetailBloc.state).thenReturn(TvsDetailHasData(testTvDetail));
        when(() => mockTvsRecomendationBloc.state).thenReturn(TvsRecommendationHasData(testTvList));
        when(() => mockTvsWatchlistBloc.state).thenReturn(const TvsWatchlistHasStatus(false));

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when series is added to wathclist',
          (WidgetTester tester) async {
        when(() => mockTvsDetailBloc.state).thenReturn(TvsDetailHasData(testTvDetail));
        when(() => mockTvsRecomendationBloc.state).thenReturn(TvsRecommendationHasData(testTvList));
        when(() => mockTvsWatchlistBloc.state).thenReturn(const TvsWatchlistHasStatus(true));

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button not display SnackBar when add to watchlist failed',
          (WidgetTester tester) async {
        when(() => mockTvsDetailBloc.state).thenReturn(TvsDetailHasData(testTvDetail));
        when(() => mockTvsRecomendationBloc.state).thenReturn(TvsRecommendationHasData(testTvList));
        when(() => mockTvsWatchlistBloc.state).thenReturn(const TvsWatchlistHasStatus(false));

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.byType(SnackBar), findsNothing);
      });
}
