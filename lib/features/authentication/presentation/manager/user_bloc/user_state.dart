part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserUnAuthenticated extends UserState {}

class UserAuthenticated extends UserState {
  final UserRepository userRepository;

  UserAuthenticated({required this.userRepository});
}

class UserAuthenticatedExpiredToken extends UserState {
  final String errMessage;

  UserAuthenticatedExpiredToken({required this.errMessage});
}

 