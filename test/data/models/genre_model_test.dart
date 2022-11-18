import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Genre Model', () {
    const tGenreEntity = Genre(
      id: 1,
      name: 'name',
    );
    const tGenreModel = GenreModel(
      id: 1,
      name: 'name',
    );
    const tGenreJson = {
      "id": 1,
      "name": "name",
    };
    test('from Json', () {
      expect(tGenreModel, GenreModel.fromJson(tGenreJson));
    });

    test('to Json', () {
      expect(tGenreJson, tGenreModel.toJson());
    });

    test('to Entity', () {
      expect(tGenreEntity, tGenreModel.toEntity());
    });
  });
}
