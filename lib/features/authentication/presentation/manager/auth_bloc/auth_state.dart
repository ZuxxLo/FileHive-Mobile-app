part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {
  final bool pWVisibility;

  AuthInitial({this.pWVisibility = false});
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {
  final String successMessage;

  SignUpSuccess({required this.successMessage});
}

class SignUpFailure extends AuthState {
  final String errorMessage;

  SignUpFailure({required this.errorMessage});
}
