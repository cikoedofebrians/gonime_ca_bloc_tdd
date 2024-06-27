import 'package:dartz/dartz.dart';
import 'package:gonime_ca_bloc_tdd/core/error/failure.dart';

abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  Future<Either<Failure, Type>> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  Future<Either<Failure, Type>> call();
}
