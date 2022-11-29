import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/presentation/bloc/movies/search_movies/search_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  group('SearchMoviesBloc', () {
    late SearchMovies searchMovies;

    setUp(() {
      searchMovies = MockSearchMovies();
    });

    SearchMoviesBloc buildBloc() => SearchMoviesBloc(searchMovies);

    test('correct initial state', () {
      expect(buildBloc().state, SearchMoviesInitial());
    });

    blocTest<SearchMoviesBloc, SearchMoviesState>(
      'emits [loading, loaded] when SearchMoviesAction is success.',
      setUp: () {
        when(() => searchMovies.execute('query'))
            .thenAnswer((_) async => Right(testMovieList));
      },
      build: () => buildBloc(),
      act: (bloc) => bloc.add(const SearchMoviesAction('query')),
      wait: const Duration(milliseconds: 300),
      expect: () => <SearchMoviesState>[
        SearchMoviesLoading(),
        SearchMoviesLoaded(testMovieList)
      ],
    );

    blocTest<SearchMoviesBloc, SearchMoviesState>(
      'emits [loading, error] when SearchMoviesAction is error',
      setUp: () {
        when(() => searchMovies.execute('query'))
            .thenAnswer((_) async => const Left(ServerFailure('Failure')));
      },
      build: () => buildBloc(),
      act: (bloc) => bloc.add(const SearchMoviesAction('query')),
      wait: const Duration(milliseconds: 300),
      expect: () => <SearchMoviesState>[
        SearchMoviesLoading(),
        const SearchMoviesError('Failure')
      ],
    );

    group('SearchMoviesEvent', () {
      test('equality', () {
        expect(
          const SearchMoviesAction('query'),
          equals(const SearchMoviesAction('query')),
        );
      });
      test('props correct', () {
        expect(
          const SearchMoviesAction('query').props,
          equals(['query']),
        );
      });
    });
  });
}
