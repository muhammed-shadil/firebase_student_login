import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_studentdata/model/student_model.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<CheckLoginStatusEvent>((event, emit) async {
      User? user;
      try {
        await Future.delayed(Duration(seconds: 3), () {
          user = _auth.currentUser;
        });

        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticatedError(message: e.toString()));
      }
    });
    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final UserCredential = await _auth.createUserWithEmailAndPassword(
            email: event.user.email.toString(),
            password: event.user.password.toString());

        final user = UserCredential.user;

        if (user != null) {
          StudentModel studentmode = StudentModel(
              email: user.email,
              uid: user.uid,
              school: event.user.school,
              username: event.user.username,
              phone: event.user.phone,
              age: event.user.age);
          FirebaseFirestore.instance
              .collection("students")
              .doc(user.uid)
              .set(studentmode.toMap());

          emit(Authenticated(user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticatedError(message: e.toString()));
      }
    });
   on<LoginEvent>((event, emit)async {


    emit(AuthLoading());
    try{
      final UserCredential = await _auth.signInWithEmailAndPassword(email: event.email, password: event.password);

      final user =UserCredential.user;
      if(user!=null){
        emit(Authenticated(user));

      }else{
        emit(UnAuthenticated());
      }
  
    }
    catch(e){
      emit(AuthenticatedError(message: e.toString()));
    }
   });





    on<LogoutEvent>((event, emit) async {
      try {
        await _auth.signOut();
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthenticatedError(message: e.toString()));
      }
    });
  }
}
