import 'package:dartz/dartz.dart';
import 'package:filehive/core/errors/api_failures.dart';
import 'package:filehive/features/authentication/data/models/login_form_model.dart';
import 'package:filehive/features/authentication/data/models/login_response.dart';
 
abstract class LoginRepo {
  Future<Either<DioFailure, AuthResponse>> loginUser(
      {required LoginFormModel loginFormModel});
}

