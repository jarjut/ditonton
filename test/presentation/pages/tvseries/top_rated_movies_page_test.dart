import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv_series/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/material_app.dart';

class MockTopRatedTvSeriesCubit extends MockCubit<TopRatedTvSeriesState>
    implements TopRatedTvSeriesCubit {}

void main() {
  group('TopRatedTvSeriesPage', () {
    late TopRatedTvSeriesCubit mockCubit;

    setUp(() {
      mockCubit = MockTopRatedTvSeriesCubit();
    });

    Widget makeTestableWidget(Widget body) {
      return BlocProvider.value(
        value: mockCubit,
        child: setMaterialApp(home: body),
      );
    }

    void fakeCubitCall() {
      when(() => mockCubit.fetchTopRatedTvSeries()).thenAnswer((_) async {});
    }

    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state).thenReturn(TopRatedTvSeriesLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state)
          .thenReturn(TopRatedTvSeriesLoaded(testTvSeriesList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state)
          .thenReturn(const TopRatedTvSeriesError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
