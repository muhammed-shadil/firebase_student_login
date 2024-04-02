part of 'fetchlocation_bloc.dart';

@immutable
sealed class FetchlocationEvent {}
class FetchLocation extends FetchlocationEvent {
  final String email;

  FetchLocation({required this.email});
}