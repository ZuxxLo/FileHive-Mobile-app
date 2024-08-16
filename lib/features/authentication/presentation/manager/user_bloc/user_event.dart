part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class LoadUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final UserRepository userRepository;

  UpdateUserEvent({required this.userRepository});
}

class DisconnectUserEvent extends UserEvent {}
