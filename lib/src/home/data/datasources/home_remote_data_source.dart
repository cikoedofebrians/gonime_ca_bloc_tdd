import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gonime_ca_bloc_tdd/core/error/exceptions.dart';
import 'package:gonime_ca_bloc_tdd/core/utils/constants.dart';
import 'package:gonime_ca_bloc_tdd/src/home/data/models/manga_model.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/entities/manga.dart';

abstract class HomeRemoteDataSource {
  Future<List<Manga>> getMangaList();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required final Dio dio}) : _dio = dio;
  final Dio _dio;

  @override
  Future<List<Manga>> getMangaList() async {
    try {
      final result = await _dio.get(homeUrl);
      return (result.data['data'] as List<dynamic>)
          .map((e) => MangaModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? "Something went wrong",
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      debugPrint(e.toString());
      throw const SystemException();
    }
  }
}
