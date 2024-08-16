import 'package:dartz/dartz.dart';
import 'package:filehive/core/errors/api_failures.dart';
import 'package:filehive/features/home/data/models/response_list_my_files.dart';

abstract class ListMyFilesRepo {
  Future<Either<DioFailure, ResponseListMyFiles>> listMyfiles(
      {required String accessToken});
}
