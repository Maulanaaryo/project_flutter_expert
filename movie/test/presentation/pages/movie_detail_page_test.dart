import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMoviesDetailBloc extends MockBloc<MoviesDetailEvent, MoviesDetailState> implements MoviesDetailBloc {}
class FakeMoviesDetailEvent extends Fake implements MoviesDetailEvent {}
class FakeMoviesDetailState extends Fake implements MoviesDetailState {}

class MockMoviesRecommendationBloc extends MockBloc<MoviesRecommendationEvent, MoviesRecommendationState> implements MoviesRecommendationBloc {}
class FakeMoviesRecommendationEvent extends Fake implements MoviesRecommendationEvent {}
class FakeMoviesRecommendationState extends Fake implements MoviesRecommendationState {}

class MockMoviesWatchlistBloc extends MockBloc<MoviesWatchlistEvent, MoviesWatchlistState> implements MoviesWatchlistBloc {}
class FakeMoviesWatchlistEvent extends Fake implements MoviesWatchlistEvent {}
class FakeMoviesWatchlistState extends Fake implements MoviesWatchlistState {}

void main() {
  late MockMoviesDetailBloc mockMoviesDetailBloc;
  late MockMoviesRecommendationBloc mockMoviesRecommendationBloc;
  late MockMoviesWatchlistBloc mockMoviesWatchlistBloc;

  setUp(() {
    mockMoviesDetailBloc = MockMoviesDetailBloc();
    mockMoviesRecommendationBloc = MockMoviesRecommendationBloc();
    mockMoviesWatchlistBloc = MockMoviesWatchlistBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeMoviesDetailEvent());
    registerFallbackValue(FakeMoviesDetailState());

    registerFallbackValue(FakeMoviesRecommendationEvent());
    registerFallbackValue(FakeMoviesRecommendationState());

    registerFallbackValue(FakeMoviesWatchlistEvent());
    registerFallbackValue(FakeMoviesWatchlistState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(providers: [
      BlocProvider<MoviesDetailBloc>(create: (_) => mockMoviesDetailBloc),
      BlocProvider<MoviesRecommendationBloc>(create: (_) => mockMoviesRecommendationBloc),
      BlocProvider<MoviesWatchlistBloc>(create: (_) => mockMoviesWatchlistBloc),
    ],
    child: MaterialApp(
      home: body,
    ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => mockMoviesDetailBloc.state).thenReturn(MoviesDetailHasData(testMovieDetail));
        when(() => mockMoviesRecommendationBloc.state).thenReturn(MoviesRecommendationHasData(testMovieList));
        when(() => mockMoviesWatchlistBloc.state).thenReturn(const MoviesWatchlistHasStatus(false));

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when movie is added to wathclist',
          (WidgetTester tester) async {
            when(() => mockMoviesDetailBloc.state).thenReturn(MoviesDetailHasData(testMovieDetail));
            when(() => mockMoviesRecommendationBloc.state).thenReturn(MoviesRecommendationHasData(testMovieList));
            when(() => mockMoviesWatchlistBloc.state).thenReturn(const MoviesWatchlistHasStatus(true));

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button not display SnackBar when add to watchlist failed',
          (WidgetTester tester) async {
            when(() => mockMoviesDetailBloc.state).thenReturn(MoviesDetailHasData(testMovieDetail));
            when(() => mockMoviesRecommendationBloc.state).thenReturn(MoviesRecommendationHasData(testMovieList));
            when(() => mockMoviesWatchlistBloc.state).thenReturn(const MoviesWatchlistHasStatus(false));

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.byType(SnackBar), findsNothing);
      });
}
