part of 'injection.dart';

final sl = GetIt.I;

Future<void> init() async {
  _initializeNetwork();
  _initializeLayers();
}

void _initializeLayers() {
  sl
    ..registerFactory(() => HomeBloc(getMangaListUsecase: sl()))
    ..registerLazySingleton(() => GetMangaListUsecase(repository: sl()))
    ..registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(remoteDataSource: sl()))
    ..registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(dio: sl()));
}

void _initializeNetwork() {
  final dio = Dio()
    ..options = BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
    );

  sl.registerLazySingleton(() => dio);
}
