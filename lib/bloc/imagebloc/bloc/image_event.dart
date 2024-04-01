// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

class Selectimage extends ImageEvent {
  final String email;

  Selectimage({required this.email});
}

class Uploadumage extends ImageEvent {
  Uint8List image;
  Uploadumage({
    required this.image,
  });
}
