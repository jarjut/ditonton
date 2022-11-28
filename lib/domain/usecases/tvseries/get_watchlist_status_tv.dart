import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetWatchListStatusTv {
  final TvRepository repository;

  GetWatchListStatusTv(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
