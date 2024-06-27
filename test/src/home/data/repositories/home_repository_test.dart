import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gonime_ca_bloc_tdd/core/error/exceptions.dart';
import 'package:gonime_ca_bloc_tdd/core/error/failure.dart';
import 'package:gonime_ca_bloc_tdd/src/home/data/datasources/home_remote_data_source.dart';
import 'package:gonime_ca_bloc_tdd/src/home/data/models/manga_model.dart';
import 'package:gonime_ca_bloc_tdd/src/home/data/repositories/home_repository.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/entities/manga.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/repositories/home_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

void main() {
  late final HomeRemoteDataSource remoteDataSource;
  late final HomeRepository homeRepository;

  setUpAll(() {
    remoteDataSource = MockHomeRemoteDataSource();
    homeRepository = HomeRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  const tMangaList = [MangaModel.dummy()];
  const tServerException =
      ServerException(message: "Something went wrong", statusCode: 400);
  group('getMangaList', () {
    test(
      'should return [Right(List<Manga>)] when function complets successfuly',
      () async {
        // Arrange
        when(() => remoteDataSource.getMangaList())
            .thenAnswer((_) async => tMangaList);

        // Act
        final result = await homeRepository.getMangaList();

        // Assert
        expect(
          result,
          const Right<Failure, List<Manga>>(tMangaList),
        );
        verify(() => remoteDataSource.getMangaList()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
        'should return [Left(ServerFailure)] when function failed because of [ServerException]',
        () async {
      // Arrange
      when(() => remoteDataSource.getMangaList()).thenThrow(tServerException);

      // Act
      final result = await homeRepository.getMangaList();

      // Assert
      expect(
        result,
        Left<Failure, List<Manga>>(
          ServerFailure(
            message: tServerException.message,
            statusCode: tServerException.statusCode,
          ),
        ),
      );
      verify(() => remoteDataSource.getMangaList()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
