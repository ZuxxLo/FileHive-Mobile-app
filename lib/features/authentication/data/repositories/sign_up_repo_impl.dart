import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:filehive/core/errors/api_failures.dart';
import 'package:filehive/core/utils/api/api_links.dart';
import 'package:filehive/core/utils/api/api_service.dart';
import 'package:filehive/features/authentication/data/models/login_response.dart';
import 'package:filehive/features/authentication/data/models/sign_up_form_model.dart';
 import 'package:filehive/features/authentication/data/repositories/sign_up_repo.dart';

class SignUpRepoImpl extends SignUpRepo {
  final ApiService apiService;

  SignUpRepoImpl(this.apiService);

  @override
  @override
  Future<Either<DioFailure, AuthResponse>> signUpUser(
      {required SignUpFormModel signUpFormModel}) async {
    try {
      print(signUpFormModel.toJson());
      var data = await apiService.post(
          endPoint: ApiLinks.signUpLink, data: signUpFormModel.toJson());

      print(data);
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
        ApiFailures(errMessage:
          e.toString(),
        ),
      );
    }
  }
}
