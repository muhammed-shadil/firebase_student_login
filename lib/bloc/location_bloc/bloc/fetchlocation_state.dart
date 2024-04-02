part of 'fetchlocation_bloc.dart';

@immutable
sealed class FetchlocationState {
  @override
  List<Object> get props => [];
}

final class FetchlocationInitial extends FetchlocationState {}

class LocationLoading extends FetchlocationState {}

class LocationLoaded extends FetchlocationState {
  final String address;

  LocationLoaded(this.address);
  @override
  List<Object> get props => [address];
}

class LocationError extends FetchlocationState {
  final String message;

  LocationError(this.message);

  @override
  List<Object> get props => [message];
}
