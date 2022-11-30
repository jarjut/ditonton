import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv_series/now_playing_tv_series/now_playing_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/tv_series/now_playing_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/material_app.dart';

class MockNowPlayingTvSeriesCubit extends MockCubit<NowPlayingTvSeriesState>
    implements NowPlayingTvSeriesCubit {}

void main() {
  group('NowPlayingTvSeriesPage', () {
    late NowPlayingTvSeriesCubit mockCubit;

    setUp(() {
      mockCubit = MockNowPlayingTvSeriesCubit();
    });

    Widget makeTestableWidget(Widget body) {
      return BlocProvider.value(
        value: mockCubit,
        child: setMaterialApp(home: body),
      );
    }

    void fakeCubitCall() {
      when(() => mockCubit.fetchNowPlayingTvSeries()).thenAnswer((_) async {});
    }

    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state).thenReturn(NowPlayingTvSeriesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester
          .pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state)
          .thenReturn(NowPlayingTvSeriesLoaded(testTvSeriesList));

      final listViewFinder = find.byType(ListView);

      await tester
          .pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state)
          .thenReturn(const NowPlayingTvSeriesError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester
          .pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
