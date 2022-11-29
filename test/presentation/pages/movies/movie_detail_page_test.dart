import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movies/movie_detail/movie_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/movie_recommendation/movie_recommendation_cubit.dart';
import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/material_app.dart';

class MockMovieDetailCubit extends MockCubit<MovieDetailState>
    implements MovieDetailCubit {}

class MockMovieRecommendationCubit extends MockCubit<MovieRecommendationState>
    implements MovieRecommendationCubit {}

void main() {
  group('MovieDetailPage', () {
    late MovieDetailCubit mockCubit;
    late MovieRecommendationCubit mockRecommendationCubit;

    setUp(() {
      mockCubit = MockMovieDetailCubit();
      mockRecommendationCubit = MockMovieRecommendationCubit();
    });

    Widget makeTestableWidget(Widget body) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: mockCubit,
          ),
          BlocProvider.value(
            value: mockRecommendationCubit,
          ),
        ],
        child: setMaterialApp(home: body),
      );
    }

    void fakeCubitCall() {
      when(() => mockCubit.fetchMovieDetail(1)).thenAnswer((_) async {});
      when(() => mockRecommendationCubit.fetchMovieRecommendations(1))
          .thenAnswer((_) async {});
      when(() => mockCubit.addWatchlist(testMovieDetail))
          .thenAnswer((_) async {});
      when(() => mockCubit.removeFromWatchlist(testMovieDetail))
          .thenAnswer((_) async {});
    }

    testWidgets(
      'Should display Circular Loading when in loading state',
      (WidgetTester tester) async {
        fakeCubitCall();
        when(() => mockCubit.state).thenReturn(
          const MovieDetailState(
            state: RequestState.loading,
          ),
        );

        final loadingFinder = find.byType(CircularProgressIndicator);

        await tester
            .pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(loadingFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Should display Error Message when failed to load data',
      (WidgetTester tester) async {
        fakeCubitCall();
        when(() => mockCubit.state).thenReturn(
          const MovieDetailState(
            state: RequestState.error,
            errorMessage: 'Error message',
          ),
        );

        final textFinder = find.text('Error message');

        await tester
            .pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(textFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Should display Error message when failed to load recommendation',
      (WidgetTester tester) async {
        fakeCubitCall();
        when(() => mockCubit.state).thenReturn(
          const MovieDetailState(
            state: RequestState.loaded,
            movieDetail: testMovieDetail,
          ),
        );
        when(() => mockRecommendationCubit.state).thenReturn(
          const MovieRecommendationError('Error message'),
        );

        final textFinder = find.text('Error message');

        await tester
            .pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(textFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Should display empty container when recommendation state is empty',
      (WidgetTester tester) async {
        fakeCubitCall();
        when(() => mockCubit.state).thenReturn(
          const MovieDetailState(
            state: RequestState.loaded,
            movieDetail: testMovieDetail,
          ),
        );
        when(() => mockRecommendationCubit.state).thenReturn(
          const MovieRecommendationInitial(),
        );

        await tester
            .pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
      },
    );
    testWidgets(
        'Watchlist button should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state).thenReturn(
        const MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          isAddedToWatchlist: false,
        ),
      );
      when(() => mockRecommendationCubit.state).thenReturn(
        MovieRecommendationLoaded(testMovieList),
      );

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when movie is added to wathclist',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state).thenReturn(
        const MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          isAddedToWatchlist: true,
        ),
      );
      when(() => mockRecommendationCubit.state).thenReturn(
        MovieRecommendationLoaded(testMovieList),
      );

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state).thenReturn(
        const MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          isAddedToWatchlist: false,
          watchlistMessage: MovieDetailCubit.watchlistAddSuccessMessage,
        ),
      );
      when(() => mockRecommendationCubit.state).thenReturn(
        MovieRecommendationLoaded(testMovieList),
      );

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.text(MovieDetailCubit.watchlistAddSuccessMessage),
        findsOneWidget,
      );
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist failed',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state).thenReturn(
        const MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          isAddedToWatchlist: false,
          watchlistMessage: 'Failed',
        ),
      );
      when(() => mockRecommendationCubit.state).thenReturn(
        MovieRecommendationLoaded(testMovieList),
      );

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when removed from watchlist',
        (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockCubit.state).thenReturn(
        const MovieDetailState(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
          isAddedToWatchlist: true,
          watchlistMessage: MovieDetailCubit.watchlistRemoveSuccessMessage,
        ),
      );
      when(() => mockRecommendationCubit.state).thenReturn(
        MovieRecommendationLoaded(testMovieList),
      );

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.text(MovieDetailCubit.watchlistRemoveSuccessMessage),
        findsOneWidget,
      );
    });
  });
}
