import 'package:firebase_studentdata/bloc/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:firebase_studentdata/model/student_model.dart';
import 'package:firebase_studentdata/view/screens/home_screen.dart';
import 'package:firebase_studentdata/view/widgets/button1.dart';
import 'package:firebase_studentdata/view/widgets/textfield1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupscreenWrapper extends StatelessWidget {
  const SignupscreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBlocBloc(),
      child: Signupscreen(),
    );
  }
}

class Signupscreen extends StatelessWidget {
  Signupscreen({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _agecontroller = TextEditingController();
  // final TextEditingController _classwordcontroller = TextEditingController();
  final TextEditingController _schoolcontroller = TextEditingController();
  final regemail = RegExp(r"^[a-zA-Z0-9_\-\.\S]{4,}[@][a-z]+[\.][a-z]{2,3}$");

  final phonreg = RegExp(r"^[6789]\d{9}$");

  final paswd =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final name = RegExp(r'^[A-Za-z]+$');

  final age = RegExp(r"^[0-9]{1,2}$");

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthBlocBlo = BlocProvider.of<AuthBlocBloc>(context);
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          // loadingsheet(context);
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is Authenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Homescreenwrapper()),
                (route) => false);
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "SIGN UP",
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Stack(children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textfield1(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter name";
                          } else if (!name.hasMatch(value)) {
                            return "enter a valid name";
                          } else {
                            return null;
                          }
                        },
                        controller: _namecontroller,
                        hint: "Name",
                        icon1: const Icon(Icons.person_4_outlined),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textfield1(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter a valid email";
                          } else if (!regemail.hasMatch(value)) {
                            return "please enter a valid email";
                          } else {
                            return null;
                          }
                        },
                        controller: _emailcontroller,
                        hint: "Email",
                        icon1: const Icon(Icons.email_outlined),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textfield1(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter a password";
                          } else if (!paswd.hasMatch(value)) {
                            return 'Password should contain at least one upper case, one lower case, one digit, one special character and  must be 8 characters in length';
                          } else {
                            return null;
                          }
                        },
                        controller: _passwordcontroller,
                        hint: "password",
                        icon1: const Icon(Icons.class_outlined),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textfield1(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter the age ";
                          } else if (int.parse(value) < 18) {
                            return "age is must be above 18";
                          } else if (!age.hasMatch(value)) {
                            return "please enter a valid age";
                          } else {
                            return null;
                          }
                        },
                        controller: _agecontroller,
                        hint: "Age",
                        icon1: const Icon(Icons.calendar_view_day_outlined),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textfield1(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter name";
                          } else if (!name.hasMatch(value)) {
                            return "enter a valid name";
                          } else {
                            return null;
                          }
                        },
                        controller: _schoolcontroller,
                        hint: "school",
                        icon1: const Icon(Icons.school_outlined),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textfield1(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter phone number";
                          } else if (value.length > 10) {
                            return "number must be 10";
                          } else if (!phonreg.hasMatch(value)) {
                            return "please enter a valid number";
                          }
                          return null;
                        },
                        controller: _phonecontroller,
                        hint: "Phone",
                        icon1: const Icon(Icons.phone),
                      ),
                    ),
                    button1(
                      btntext: "Sign up",
                      onpressed: () {
                        StudentModel student = StudentModel(
                            username: _namecontroller.text,
                            password: _passwordcontroller.text,
                            age: _agecontroller.text,
                            email: _emailcontroller.text,
                            phone: _phonecontroller.text,
                            school: _schoolcontroller.text);
                        AuthBlocBlo.add(SignupEvent(user: student));
                        // loadingsheet(context);
                      },
                    )
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
