import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gonime_ca_bloc_tdd/src/home/data/models/manga_model.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/entities/manga.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tManga = MangaModel.dummy();
  test(
    'should be a subclass of [Manga] entity',
    () {
      // Assert
      expect(tManga, isA<Manga>());
    },
  );

  group('fromJson', () {
    test('should return a [MangaModel] with the correct datas', () {
      // Act
      final json = jsonDecode(fixture("manga.json")) as Map<String, dynamic>;
      final result = MangaModel.fromJson(json);

      // Assert
      expect(result, tManga);
    });
  });

  group(
    'toJson',
    () {
      test('should return [Map<String, dynamic>] with the correct data', () {
        // Act
        final result = tManga.toJson();

        // Assert
        expect(
          result['mal_id'],
          tManga.malId,
        );
      });
    },
  );

  group('copyWith', () {
    test('should return a [MangaModel] with different data', () {
      // Act
      final result = tManga.copyWith(title: "Fullmetal Alchemist");

      // Assert
      expect(result.title, equals('Fullmetal Alchemist'));
    });
  });
}
