import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gonime_ca_bloc_tdd/core/error/failure.dart';
import 'package:gonime_ca_bloc_tdd/src/home/data/models/manga_model.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/entities/manga.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/repositories/home_repository.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/usecases/get_manga_list_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late final HomeRepository homeRepository;
  late final GetMangaListUsecase usecase;

  setUpAll(() async {
    homeRepository = MockHomeRepository();
    usecase = GetMangaListUsecase(repository: homeRepository);
  });

  const tMangaList = [MangaModel.dummy()];
  test(
      "should called the [HomeRepository.getMangaList] and return [Right(List<Manga>)]",
      () async {
    // Arrange
    when(() => homeRepository.getMangaList())
        .thenAnswer((_) async => const Right(tMangaList));

    // Act
    final result = await usecase();

    // Assert
    expect(result, const Right<Failure, List<Manga>>(tMangaList));
    verify(
      () => homeRepository.getMangaList(),
    ).called(1);
    verifyNoMoreInteractions(homeRepository);
  });
}
