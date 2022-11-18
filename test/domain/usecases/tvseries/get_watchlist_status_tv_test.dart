import 'package:ditonton/domain/usecases/tvseries/get_watchlist_status_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchListStatusTv(mockTvRepository);
  });

  const tTvSeriesId = 1;

  group('get watchlist status tv usecase', () {
    test('should get watchlist status from repository', () async {
      // arrange
      when(mockTvRepository.isAddedToWatchlist(tTvSeriesId))
          .thenAnswer((_) async => true);
      // act
      final result = await usecase.execute(tTvSeriesId);
      // assert
      expect(result, true);
    });
  });
}
