import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_detail/tv_series_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_recommendation/tv_series_recommendation_cubit.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/material_app.dart';

class MockTvSeriesDetailCubit extends MockCubit<TvSeriesDetailState>
    implements TvSeriesDetailCubit {}

class MockTvSeriesRecommendationCubit
    extends MockCubit<TvSeriesRecommendationState>
    implements TvSeriesRecommendationCubit {}

void main() {
  late TvSeriesDetailCubit mockDetailCubit;
  late TvSeriesRecommendationCubit mockRecommendationCubit;

  setUp(() {
    mockDetailCubit = MockTvSeriesDetailCubit();
    mockRecommendationCubit = MockTvSeriesRecommendationCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: mockDetailCubit),
        BlocProvider.value(value: mockRecommendationCubit),
      ],
      child: setMaterialApp(home: body),
    );
  }

  void fakeCubitCall() {
    when(() => mockDetailCubit.fetchTvDetail(1)).thenAnswer((_) async {});
    when(() => mockRecommendationCubit.fetchTvSeriesRecommendation(1))
        .thenAnswer((_) async {});
    when(() => mockDetailCubit.addWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async {});
    when(() => mockDetailCubit.removeFromWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async {});
  }

  testWidgets(
    'Should display Error Message when failed to load data',
    (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockDetailCubit.state).thenReturn(
        const TvSeriesDetailState(
          state: RequestState.error,
          errorMessage: 'Error message',
        ),
      );

      final textFinder = find.text('Error message');

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Should display Error message when failed to load recommendation',
    (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockDetailCubit.state).thenReturn(
        TvSeriesDetailState(
          state: RequestState.loaded,
          tvSeriesDetail: testTvSeriesDetail,
        ),
      );
      when(() => mockRecommendationCubit.state).thenReturn(
        const TvSeriesRecommendationError('Error message'),
      );

      final textFinder = find.text('Error message');

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Should display empty container when recommendation state is empty',
    (WidgetTester tester) async {
      fakeCubitCall();
      when(() => mockDetailCubit.state).thenReturn(
        TvSeriesDetailState(
          state: RequestState.loaded,
          tvSeriesDetail: testTvSeriesDetail,
        ),
      );
      when(() => mockRecommendationCubit.state).thenReturn(
        const TvSeriesRecommendationInitial(),
      );

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));
    },
  );

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist',
      (WidgetTester tester) async {
    fakeCubitCall();
    when(() => mockDetailCubit.state).thenReturn(
      TvSeriesDetailState(
        state: RequestState.loaded,
        tvSeriesDetail: testTvSeriesDetail,
        isAddedToWatchlist: false,
      ),
    );
    when(() => mockRecommendationCubit.state).thenReturn(
      TvSeriesRecommendationLoaded(testTvSeriesList),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv series is added to wathclist',
      (WidgetTester tester) async {
    fakeCubitCall();
    when(() => mockDetailCubit.state).thenReturn(
      TvSeriesDetailState(
        state: RequestState.loaded,
        tvSeriesDetail: testTvSeriesDetail,
        isAddedToWatchlist: true,
      ),
    );
    when(() => mockRecommendationCubit.state).thenReturn(
      TvSeriesRecommendationLoaded(testTvSeriesList),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    fakeCubitCall();
    when(() => mockDetailCubit.state).thenReturn(
      TvSeriesDetailState(
        state: RequestState.loaded,
        tvSeriesDetail: testTvSeriesDetail,
        isAddedToWatchlist: false,
        watchlistMessage: TvSeriesDetailCubit.watchlistAddSuccessMessage,
      ),
    );
    when(() => mockRecommendationCubit.state).thenReturn(
      TvSeriesRecommendationLoaded(testTvSeriesList),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    fakeCubitCall();
    when(() => mockDetailCubit.state).thenReturn(
      TvSeriesDetailState(
        state: RequestState.loaded,
        tvSeriesDetail: testTvSeriesDetail,
        isAddedToWatchlist: false,
        watchlistMessage: 'Failed',
      ),
    );
    when(() => mockRecommendationCubit.state).thenReturn(
      TvSeriesRecommendationLoaded(testTvSeriesList),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

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
    when(() => mockDetailCubit.state).thenReturn(
      TvSeriesDetailState(
        state: RequestState.loaded,
        tvSeriesDetail: testTvSeriesDetail,
        isAddedToWatchlist: true,
        watchlistMessage: TvSeriesDetailCubit.watchlistRemoveSuccessMessage,
      ),
    );
    when(() => mockRecommendationCubit.state).thenReturn(
      TvSeriesRecommendationLoaded(testTvSeriesList),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });
}
