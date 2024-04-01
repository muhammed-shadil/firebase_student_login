import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<Selectimage>((event, emit) async {
      try {
        final ImagePicker _imagePicker = ImagePicker();
        XFile? res = await _imagePicker.pickImage(source: ImageSource.gallery);

        if (res != null) {
          final memoryimg = await res.readAsBytes();
          String filename =
              'Images/${DateTime.now().millisecondsSinceEpoch}.png';

          Reference sr = FirebaseStorage.instance.ref().child(filename);

          await sr.putFile(File(res.path));

          String imageurl = await sr.getDownloadURL();

          await FirebaseFirestore.instance
              .collection("students")
              .where("email", isEqualTo: event.email)
              .get()
              .then((value) {
            for (var doc in value.docs) {
              doc.reference.update({'image': imageurl});
            }
          });
          emit(uploadimagesucces(imageurl: memoryimg));
        } else {
          emit(Uploadimagefailure(msg: "image not selected"));
        }
      } catch (e) {
        emit(Uploadimagefailure(msg: "Error ,while picking image $e"));
      }
    });

    on<Uploadumage>((event, emit) {
      emit(Uploadimageloading());
      try {
        if (event.image.isNotEmpty) {}
      } catch (e) {
        emit(Uploadimagefailure(msg: e.toString()));
      }
    });
  }
}
