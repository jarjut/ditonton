import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlistTv(mockTvRepository);
  });

  group('remove watchlist tv usecase', () {
    test('should remove watchlist tv with message', () async {
      const tMessage = 'Removed from watchlist';
      // arrange
      when(mockTvRepository.removeWatchlist(testTvSeriedDetail))
          .thenAnswer((_) async => const Right(tMessage));
      // act
      final result = await usecase.execute(testTvSeriedDetail);
      // assert
      expect(result, const Right(tMessage));
    });
  });
}
