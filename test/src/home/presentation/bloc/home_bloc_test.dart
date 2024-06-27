import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gonime_ca_bloc_tdd/core/error/failure.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/entities/manga.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/usecases/get_manga_list_usecase.dart';
import 'package:gonime_ca_bloc_tdd/src/home/presentation/bloc/home_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetMangaListUsecase extends Mock implements GetMangaListUsecase {}

void main() {
  late final GetMangaListUsecase usecase;
  late final HomeBloc bloc;

  setUpAll(() {
    usecase = MockGetMangaListUsecase();
    bloc = HomeBloc(getMangaListUsecase: usecase);
  });

  const tMangaList = [
    Manga.dummy(),
  ];

  const tServerFailure = ServerFailure(
    message: "Something went wrong",
    statusCode: 404,
  );

  tearDown(
    () => bloc.close(),
  );

  test('HomeBloc initial state should be [HomeInitial]', () {
    expect(bloc.state, HomeInitial());
  });

  group("FetchMangaEvent", () {
    blocTest<HomeBloc, HomeState>(
      'should emit [HomeLoading, HomeSuccess] when operation is success',
      build: () {
        when(() => usecase()).thenAnswer(
          (_) async => const Right(
            tMangaList,
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(FetchMangaEvent()),
      expect: () async => [
        HomeLoading(),
        const HomeSuccess(
          mangaList: tMangaList,
        ),
      ],
      verify: (_) {
        verify(() => usecase()).called(1);
        verifyNoMoreInteractions(usecase);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'should emit [HomeLoading, HomeError] when operation is failed',
      build: () {
        when(() => usecase())
            .thenAnswer((_) async => const Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchMangaEvent()),
      expect: () async => [
        HomeLoading(),
        HomeError(errorMessage: tServerFailure.message),
      ],
      verify: (_) {
        verify(() => usecase()).called(1);
        verifyNoMoreInteractions(usecase);
      },
    );
  });
}
