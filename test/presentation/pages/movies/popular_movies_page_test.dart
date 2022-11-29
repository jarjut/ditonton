import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movies/popular_movies/popular_movies_cubit.dart';
import 'package:ditonton/presentation/pages/movies/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/material_app.dart';

class MockPopularMoviesCubit extends MockCubit<PopularMoviesState>
    implements PopularMoviesCubit {}

void main() {
  group('PopularMoviesPage', () {
    late PopularMoviesCubit mockCubit;

    setUp(() {
      mockCubit = MockPopularMoviesCubit();
    });

    Widget makeTestableWidget(Widget body) {
      return BlocProvider.value(
        value: mockCubit,
        child: setMaterialApp(home: body),
      );
    }

    void fakeCubitCall() {
      when(() => mockCubit.fetchPopularMovies()).thenAnswer((_) async {});
    }

    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state).thenReturn(PopularMoviesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state)
          .thenReturn(PopularMoviesLoaded(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state)
          .thenReturn(const PopularMoviesError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
