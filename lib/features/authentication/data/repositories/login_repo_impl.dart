import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:filehive/core/errors/api_failures.dart';
import 'package:filehive/core/utils/api/api_links.dart';
import 'package:filehive/core/utils/api/api_service.dart';
import 'package:filehive/features/authentication/data/models/login_form_model.dart';
import 'package:filehive/features/authentication/data/models/login_response.dart';
import 'package:filehive/features/authentication/data/repositories/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  final ApiService apiService;

  LoginRepoImpl(this.apiService);

  @override
  Future<Either<DioFailure, AuthResponse>> loginUser(
      {required LoginFormModel loginFormModel}) async {
    try {
      var data = await apiService.post(
          endPoint: ApiLinks.loginLink, data: loginFormModel.toJson());

      AuthResponse authResponse = AuthResponse.fromJson(data);

      return right(authResponse);
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
