import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchlistTv(mockTvRepository);
  });

  group('save watchlist tv usecase', () {
    test('should save watchlist tv with message', () async {
      const tMessage = 'Added to Watchlist';
      // arrange
      when(mockTvRepository.saveWatchlist(testTvSeriedDetail))
          .thenAnswer((_) async => const Right(tMessage));
      // act
      final result = await usecase.execute(testTvSeriedDetail);
      // assert
      expect(result, const Right(tMessage));
    });
  });
}
