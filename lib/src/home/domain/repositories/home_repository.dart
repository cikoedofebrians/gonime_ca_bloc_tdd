import 'package:dartz/dartz.dart';
import 'package:gonime_ca_bloc_tdd/core/error/failure.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/entities/manga.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Manga>>> getMangaList();
}
