import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series/search_tv_series/search_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockSearchTvSeries extends Mock implements SearchTvSeries {}

void main() {
  group('SearchTvSeriesBloc', () {
    late SearchTvSeries searchTvSeries;

    setUp(() {
      searchTvSeries = MockSearchTvSeries();
    });

    SearchTvSeriesBloc buildBloc() => SearchTvSeriesBloc(searchTvSeries);

    test('correct initial state', () {
      expect(buildBloc().state, SearchTvSeriesInitial());
    });

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'emits [loading, loaded] when SearchTvSeriesAction is success.',
      setUp: () {
        when(() => searchTvSeries.execute('query'))
            .thenAnswer((_) async => Right(testTvSeriesList));
      },
      build: () => buildBloc(),
      act: (bloc) => bloc.add(const SearchTvSeriesAction('query')),
      wait: const Duration(milliseconds: 300),
      expect: () => <SearchTvSeriesState>[
        SearchTvSeriesLoading(),
        SearchTvSeriesLoaded(testTvSeriesList)
      ],
    );

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'emits [loading, error] when SearchTvSeriesAction is error',
      setUp: () {
        when(() => searchTvSeries.execute('query'))
            .thenAnswer((_) async => const Left(ServerFailure('Failure')));
      },
      build: () => buildBloc(),
      act: (bloc) => bloc.add(const SearchTvSeriesAction('query')),
      wait: const Duration(milliseconds: 300),
      expect: () => <SearchTvSeriesState>[
        SearchTvSeriesLoading(),
        const SearchTvSeriesError('Failure')
      ],
    );
  });

  group('SearchTvSeriesEvent', () {
    test('equality', () {
      expect(
        const SearchTvSeriesAction('query'),
        equals(const SearchTvSeriesAction('query')),
      );
    });
    test('props correct', () {
      expect(
        const SearchTvSeriesAction('query').props,
        equals(['query']),
      );
    });
  });
}
