import 'package:dartz/dartz.dart';
import 'package:filehive/core/errors/api_failures.dart';
import 'package:filehive/features/authentication/data/models/login_response.dart';
import 'package:filehive/features/authentication/data/models/sign_up_form_model.dart';
 
abstract class SignUpRepo {
  Future<Either<DioFailure, AuthResponse>> signUpUser(
      {required SignUpFormModel signUpFormModel});
}
