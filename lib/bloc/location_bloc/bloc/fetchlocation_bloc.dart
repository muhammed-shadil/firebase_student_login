import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'fetchlocation_event.dart';
part 'fetchlocation_state.dart';

class FetchlocationBloc extends Bloc<FetchlocationEvent, FetchlocationState> {
  FetchlocationBloc() : super(FetchlocationInitial()) {
    on<FetchlocationEvent>((event, emit) async {
      if (event is FetchLocation) {
        emit(LocationLoading());
        try {
          final String address = await _getAddress();
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await FirebaseFirestore.instance
                .collection('students')
                .where('email', isEqualTo: event.email)
                .get()
                .then((value) {
              value.docs.forEach((doc) {
                doc.reference.update({'location': address});
              });
            });
          }

          emit(LocationLoaded(address));
        } catch (e) {
          emit(LocationError("failed to get locatiob:$e"));
        }
      }
    });
  }
  Future<String> _getAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // return await Geolocator.getCurrentPosition();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    return "${place.street} , ${place.locality}, ${place.administrativeArea} ,${place.country} , ${place.postalCode} ,";
  }
}
