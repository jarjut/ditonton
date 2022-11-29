import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv_series/season_episodes/season_episodes_cubit.dart';
import 'package:ditonton/presentation/pages/tv_series/season_episodes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/material_app.dart';

class MockSeasonEpisodesCubit extends MockCubit<SeasonEpisodesState>
    implements SeasonEpisodesCubit {}

void main() {
  late SeasonEpisodesCubit mockCubit;

  setUp(() {
    mockCubit = MockSeasonEpisodesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider.value(
      value: mockCubit,
      child: setMaterialApp(home: body),
    );
  }

  void fakeCubitCall() {
    when(() => mockCubit.fetchSeasonEpisodes(1, 1)).thenAnswer((_) async {});
  }

  group('SeasonEpisodesPage', () {
    final testTvDetail = testTvSeriesDetail;
    final testSeason = testTvSeriesDetail.seasons.first;
    testWidgets(
      'should display error message when failed to load data',
      (WidgetTester tester) async {
        fakeCubitCall();
        when(() => mockCubit.state)
            .thenReturn(const SeasonEpisodesError('Error message'));

        final textFinder = find.text('Error message');

        await tester.pumpWidget(
          makeTestableWidget(
            SeasonEpisodesPage(
              tvSeriesDetail: testTvDetail,
              season: testSeason,
            ),
          ),
        );

        expect(textFinder, findsOneWidget);
      },
    );

    testWidgets(
      'should display loading indicator when loading data',
      (WidgetTester tester) async {
        fakeCubitCall();
        when(() => mockCubit.state).thenReturn(const SeasonEpisodesLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(
          makeTestableWidget(
            SeasonEpisodesPage(
              tvSeriesDetail: testTvDetail,
              season: testSeason,
            ),
          ),
        );

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      },
    );

    testWidgets(
      'should display No episode found when episode is empty',
      (WidgetTester tester) async {
        fakeCubitCall();
        when(() => mockCubit.state).thenReturn(const SeasonEpisodesLoaded([]));

        final textFinder = find.text('No episode found');

        await tester.pumpWidget(
          makeTestableWidget(
            SeasonEpisodesPage(
              tvSeriesDetail: testTvDetail,
              season: testSeason,
            ),
          ),
        );

        expect(textFinder, findsOneWidget);
      },
    );

    testWidgets(
      'should display listView when episode loaded',
      (WidgetTester tester) async {
        fakeCubitCall();
        when(() => mockCubit.state)
            .thenReturn(SeasonEpisodesLoaded(testEpisodeList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(
          makeTestableWidget(
            SeasonEpisodesPage(
              tvSeriesDetail: testTvDetail,
              season: testSeason,
            ),
          ),
        );

        expect(listViewFinder, findsOneWidget);
      },
    );
  });
}
