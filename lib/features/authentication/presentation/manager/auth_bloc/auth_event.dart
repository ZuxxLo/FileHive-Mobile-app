part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginFormModel loginFormModel;

  LoginEvent({required this.loginFormModel});
}

class SignUpEvent extends AuthEvent {
  final SignUpFormModel signUpFormModel;

  SignUpEvent({required this.signUpFormModel});
}

class ForgotPasswordEvent extends AuthEvent {}

class TogglePWVisibilityEvent extends AuthEvent {}
