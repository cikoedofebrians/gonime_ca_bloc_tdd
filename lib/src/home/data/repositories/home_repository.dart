import 'package:dartz/dartz.dart';
import 'package:gonime_ca_bloc_tdd/core/error/exceptions.dart';
import 'package:gonime_ca_bloc_tdd/core/error/failure.dart';
import 'package:gonime_ca_bloc_tdd/src/home/data/datasources/home_remote_data_source.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/entities/manga.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl({required final HomeRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<Manga>>> getMangaList() async {
    try {
      final result = await _remoteDataSource.getMangaList();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on SystemException catch (e) {
      return Left(SystemFailure(message: e.message));
    }
  }
}
