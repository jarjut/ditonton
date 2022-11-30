import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv_series/popular_tv_series/popular_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/material_app.dart';

class MockPopularTvSeriesCubit extends MockCubit<PopularTvSeriesState>
    implements PopularTvSeriesCubit {}

void main() {
  group('PopularTvSeriesPage', () {
    late PopularTvSeriesCubit mockCubit;

    setUp(() {
      mockCubit = MockPopularTvSeriesCubit();
    });

    Widget makeTestableWidget(Widget body) {
      return BlocProvider.value(
        value: mockCubit,
        child: setMaterialApp(home: body),
      );
    }

    void fakeCubitCall() {
      when(() => mockCubit.fetchPopularTvSeries()).thenAnswer((_) async {});
    }

    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state).thenReturn(PopularTvSeriesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state)
          .thenReturn(PopularTvSeriesLoaded(testTvSeriesList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state)
          .thenReturn(const PopularTvSeriesError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
