// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/presentation/pages/tv_series_detail_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:ditonton/common/state_enum.dart' as _i9;
import 'package:ditonton/domain/entities/tv_series/tv_series.dart' as _i7;
import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart'
    as _i10;
import 'package:ditonton/domain/usecases/tv_series/get_detail_tv_series.dart'
    as _i2;
import 'package:ditonton/domain/usecases/tv_series/get_recommendations_tv_series.dart'
    as _i3;
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_status_tv_series.dart'
    as _i4;
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart'
    as _i6;
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv_series.dart'
    as _i5;
import 'package:ditonton/presentation/provider/tv_series/tv_series_detail_notifier.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetDetailTvSeries_0 extends _i1.Fake
    implements _i2.GetDetailTvSeries {}

class _FakeGetRecommendationsTvSeries_1 extends _i1.Fake
    implements _i3.GetRecommendationsTvSeries {}

class _FakeGetWatchListStatusTvSeries_2 extends _i1.Fake
    implements _i4.GetWatchListStatusTvSeries {}

class _FakeSaveWatchlistTvSeries_3 extends _i1.Fake
    implements _i5.SaveWatchlistTvSeries {}

class _FakeRemoveWatchlistTvSeries_4 extends _i1.Fake
    implements _i6.RemoveWatchlistTvSeries {}

class _FakeTvSeriesDetail_5 extends _i1.Fake implements _i7.TvSeriesDetail {}

/// A class which mocks [TvSeriesDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesDetailNotifier extends _i1.Mock
    implements _i8.TvSeriesDetailNotifier {
  MockTvSeriesDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetDetailTvSeries get getDetailTvSeries =>
      (super.noSuchMethod(Invocation.getter(#getDetailTvSeries),
          returnValue: _FakeGetDetailTvSeries_0()) as _i2.GetDetailTvSeries);
  @override
  _i3.GetRecommendationsTvSeries get getRecommendationsTvSeries =>
      (super.noSuchMethod(Invocation.getter(#getRecommendationsTvSeries),
              returnValue: _FakeGetRecommendationsTvSeries_1())
          as _i3.GetRecommendationsTvSeries);
  @override
  _i4.GetWatchListStatusTvSeries get getWatchListStatusTvSeries =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatusTvSeries),
              returnValue: _FakeGetWatchListStatusTvSeries_2())
          as _i4.GetWatchListStatusTvSeries);
  @override
  _i5.SaveWatchlistTvSeries get saveWatchlistTvSeries =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlistTvSeries),
              returnValue: _FakeSaveWatchlistTvSeries_3())
          as _i5.SaveWatchlistTvSeries);
  @override
  _i6.RemoveWatchlistTvSeries get removeWatchlistTvSeries =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlistTvSeries),
              returnValue: _FakeRemoveWatchlistTvSeries_4())
          as _i6.RemoveWatchlistTvSeries);
  @override
  _i7.TvSeriesDetail get tv => (super.noSuchMethod(Invocation.getter(#tv),
      returnValue: _FakeTvSeriesDetail_5()) as _i7.TvSeriesDetail);
  @override
  _i9.RequestState get tvState =>
      (super.noSuchMethod(Invocation.getter(#tvState),
          returnValue: _i9.RequestState.Empty) as _i9.RequestState);
  @override
  List<_i10.TvSeries> get tvRecommendations =>
      (super.noSuchMethod(Invocation.getter(#tvRecommendations),
          returnValue: <_i10.TvSeries>[]) as List<_i10.TvSeries>);
  @override
  _i9.RequestState get recommendationTvState =>
      (super.noSuchMethod(Invocation.getter(#recommendationTvState),
          returnValue: _i9.RequestState.Empty) as _i9.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get isAddedToWatchlistTv =>
      (super.noSuchMethod(Invocation.getter(#isAddedToWatchlistTv),
          returnValue: false) as bool);
  @override
  String get watchlistMessageTv => (super
          .noSuchMethod(Invocation.getter(#watchlistMessageTv), returnValue: '')
      as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i11.Future<void> fetchTvDetail(int? id) => (super.noSuchMethod(
      Invocation.method(#fetchTvDetail, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> addWatchlistTv(_i7.TvSeriesDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#addWatchlistTv, [tv]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> removeFromWatchlistTv(_i7.TvSeriesDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlistTv, [tv]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> loadWatchlistStatusTv(int? id) => (super.noSuchMethod(
      Invocation.method(#loadWatchlistStatusTv, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);
  @override
  void addListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
