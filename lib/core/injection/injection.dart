import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gonime_ca_bloc_tdd/core/utils/constants.dart';
import 'package:gonime_ca_bloc_tdd/src/home/data/datasources/home_remote_data_source.dart';
import 'package:gonime_ca_bloc_tdd/src/home/data/repositories/home_repository.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/repositories/home_repository.dart';
import 'package:gonime_ca_bloc_tdd/src/home/domain/usecases/get_manga_list_usecase.dart';
import 'package:gonime_ca_bloc_tdd/src/home/presentation/bloc/home_bloc.dart';

part 'injection.main.dart';
