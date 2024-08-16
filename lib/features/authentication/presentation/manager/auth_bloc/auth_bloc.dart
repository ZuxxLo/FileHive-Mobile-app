import 'package:filehive/core/utils/service_locator.dart';
import 'package:filehive/features/authentication/presentation/manager/user_bloc/user_bloc.dart';
import 'package:filehive/features/authentication/data/models/login_form_model.dart';
import 'package:filehive/features/authentication/data/models/sign_up_form_model.dart';
import 'package:filehive/features/authentication/data/models/user_repo_model.dart';
import 'package:filehive/features/authentication/data/repositories/sign_up_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filehive/features/authentication/data/repositories/login_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRepo loginRepo;
  final SignUpRepo signUpRepo;

  @override
  Future<void> close() {
    print("--------------------closed AuthBloc--------------------");
    return super.close();
  }

  AuthBloc({required this.loginRepo, required this.signUpRepo})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());

        var response =
            await loginRepo.loginUser(loginFormModel: loginFormModel);

        response.fold(
          (failure) {
            emit(LoginFailure(errorMessage: failure.errMessage));
          },
          (authResponse) {
            final userRepo = ServiceLocator.getIt<UserRepository>();

            userRepo.setUser(authResponse.user!, authResponse.accessToken!);

            ServiceLocator.getIt<UserBloc>()
                .add(UpdateUserEvent(userRepository: userRepo));

            emit(LoginSuccess());
          },
        );
      } else if (event is SignUpEvent) {
        emit(SignUpLoading());
        var response =
            await signUpRepo.signUpUser(signUpFormModel: signUpFormModel);

        response.fold(
          (failure) {
            emit(SignUpFailure(errorMessage: failure.errMessage));
          },
          (authResponse) {
            emit(SignUpSuccess(successMessage: authResponse.message!));
          },
        );
      } else if (event is TogglePWVisibilityEvent) {
        pWVisibility = !pWVisibility;

        emit(AuthInitial(pWVisibility: pWVisibility));
      }
    });
  }
  bool pWVisibility = false;

  LoginFormModel loginFormModel = LoginFormModel();
  onChangedLoginEmailInput(String value) {
    loginFormModel.email = value;
  }

  onChangeLoginPasswordInput(String value) {
    loginFormModel.password = value;
  }

  SignUpFormModel signUpFormModel = SignUpFormModel();
  onChangeSignUpFirstNameInput(String value) {
    signUpFormModel.firstName = value;
  }

  onChangeSignUpLastNameInput(String value) {
    signUpFormModel.lastName = value;
  }

  onChangedSignUpEmailInput(String value) {
    signUpFormModel.email = value;
  }

  onChangeSignUpPasswordInput(String value) {
    signUpFormModel.password = value;
  }
}
