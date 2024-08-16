import 'package:dartz/dartz.dart';
import 'package:filehive/core/errors/api_failures.dart';
import 'package:filehive/features/authentication/data/models/login_response.dart';

abstract class UserInfoRepo {
  Future<Either<DioFailure, User>> getUserInfos({required String accessToken});
}
