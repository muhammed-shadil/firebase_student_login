// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class Authenticated extends AuthBlocState {
  User? user;
  Authenticated(
    this.user,
  );
}

class UnAuthenticated extends AuthBlocState {}



class AuthenticatedError extends AuthBlocState{
  final String message;

  AuthenticatedError({required this.message});
}