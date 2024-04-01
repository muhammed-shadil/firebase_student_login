part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

class CheckLoginStatusEvent extends AuthBlocEvent {}

class LoginEvent extends AuthBlocEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class SignupEvent extends AuthBlocEvent {
  final StudentModel user;

  SignupEvent({required this.user});
}

class LogoutEvent extends AuthBlocEvent {}

class UpdateEvent extends AuthBlocEvent {
  final StudentModel user;

  UpdateEvent({required this.user});
}

class DeletedEvent extends AuthBlocEvent {
  final String email;
  final String password;

  DeletedEvent({required this.email, required this.password});
}
