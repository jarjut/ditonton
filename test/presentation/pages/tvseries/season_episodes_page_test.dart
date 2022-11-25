import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/presentation/pages/tv_series/season_episodes_page.dart';
import 'package:ditonton/presentation/provider/season_episodes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/material_app.dart';
import 'season_episodes_page_test.mocks.dart';

@GenerateMocks([SeasonEpisodesNotifier])
void main() {
  late MockSeasonEpisodesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSeasonEpisodesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SeasonEpisodesNotifier>.value(
      value: mockNotifier,
      child: setMaterialApp(home: body),
    );
  }

  group('SeasonEpisodesPage', () {
    final testTvDetail = testTvSeriesDetail;
    final testSeason = testTvSeriesDetail.seasons.first;
    testWidgets(
      'should display error message when failed to load data',
      (WidgetTester tester) async {
        when(mockNotifier.episodeListState).thenReturn(RequestState.error);
        when(mockNotifier.message).thenReturn('Error message');

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
        when(mockNotifier.episodeListState).thenReturn(RequestState.loading);

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
        when(mockNotifier.episodeListState).thenReturn(RequestState.loaded);
        when(mockNotifier.episodeList).thenReturn(<Episode>[]);

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
        when(mockNotifier.episodeListState).thenReturn(RequestState.loaded);
        when(mockNotifier.episodeList).thenReturn(testEpisodeList);

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
