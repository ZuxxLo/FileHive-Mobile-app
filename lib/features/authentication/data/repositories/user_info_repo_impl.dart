import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:filehive/core/errors/api_failures.dart';
import 'package:filehive/core/utils/api/api_links.dart';
import 'package:filehive/core/utils/api/api_service.dart';
import 'package:filehive/features/authentication/data/models/login_response.dart';
import 'package:filehive/features/authentication/data/repositories/user_info_repo.dart';

class UserInfoRepoImpl extends UserInfoRepo {
  final ApiService apiService;

  UserInfoRepoImpl(this.apiService);

  @override
  Future<Either<DioFailure, User>> getUserInfos(
      {required String accessToken}) async {
    try {
      var data = await apiService.get(
          endPoint: ApiLinks.myInfosLink, accessToken: accessToken);
      User user = User.fromJsonMy(data);
      return right(user);
    } catch (e) {
      print("***************");
      print(e);
      print("***************");

      if (e is DioException) {
        return left(
          ApiFailures.fromDioError(e),
        );
      }
      return left(
        ApiFailures(
          errMessage: e.toString(),
        ),
      );
    }
  }
}
