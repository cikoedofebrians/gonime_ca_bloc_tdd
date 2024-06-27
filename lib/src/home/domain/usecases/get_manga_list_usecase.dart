import 'package:dartz/dartz.dart';
import 'package:gonime_ca_bloc_tdd/core/error/failure.dart';
import 'package:gonime_ca_bloc_tdd/core/usecases/usecase.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/repositories/home_repository.dart';

class GetMangaListUsecase extends UsecaseWithoutParams {
  const GetMangaListUsecase({required final HomeRepository repository})
      : _repository = repository;

  final HomeRepository _repository;
  @override
  Future<Either<Failure, dynamic>> call() async => _repository.getMangaList();
}
