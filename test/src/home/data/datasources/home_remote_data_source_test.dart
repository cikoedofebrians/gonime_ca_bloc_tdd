import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gonime_ca_bloc_tdd/core/error/exceptions.dart';
import 'package:gonime_ca_bloc_tdd/core/utils/constants.dart';
import 'package:gonime_ca_bloc_tdd/src/home/data/datasources/home_remote_data_source.dart';
import 'package:gonime_ca_bloc_tdd/src/home/data/models/manga_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final HomeRemoteDataSource remoteDataSource;

  setUpAll(() {
    dio = MockDio();
    remoteDataSource = HomeRemoteDataSourceImpl(dio: dio);
  });

  const tServerException =
      ServerException(message: "Something went wrong", statusCode: 400);

  final tMangasJson =
      jsonDecode(fixture("mangas.json")) as Map<String, dynamic>;
  group('getMangaList', () {
    test(
      'should return a [List<User>] when API called successfully',
      () async {
        // Arrange
        when(
          () => dio.get(homeUrl),
        ).thenAnswer((_) async => Response(
              requestOptions: RequestOptions(),
              data: tMangasJson,
              statusCode: 200,
            ));
        // Act
        final result = await remoteDataSource.getMangaList();
        // Assert
        expect(result[0], equals(const MangaModel.dummy()));
        verify(() => dio.get(homeUrl)).called(1);
        verifyNoMoreInteractions(dio);
      },
    );

    test('should return a [ServerException] when API called error', () async {
      // Arrange
      when(() => dio.get(homeUrl)).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          response: Response(
            requestOptions: RequestOptions(),
            data: {
              "error": "Something went wrong",
            },
            statusCode: 400,
          ),
        ),
      );
      // Act
      final result = remoteDataSource.getMangaList;
      expect(() => result(), throwsA(tServerException));
    });
  });
}
