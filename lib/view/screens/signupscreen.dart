import 'package:firebase_studentdata/bloc/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:firebase_studentdata/model/student_model.dart';
import 'package:firebase_studentdata/view/screens/home_screen.dart';
import 'package:firebase_studentdata/view/widgets/button1.dart';
import 'package:firebase_studentdata/view/widgets/loading_indicator.dart';
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

  @override
  Widget build(BuildContext context) {
    final AuthBlocBlo = BlocProvider.of<AuthBlocBloc>(context);
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          // loadingsheet(context);
          return Center(
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
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Textfield1(
                        controller: _namecontroller,
                        hint: "Name",
                        icon1: Icon(Icons.person_4_outlined),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Textfield1(
                        controller: _emailcontroller,
                        hint: "Email",
                        icon1: Icon(Icons.email_outlined),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Textfield1(
                        controller: _passwordcontroller,
                        hint: "password",
                        icon1: Icon(Icons.class_outlined),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Textfield1(
                        controller: _agecontroller,
                        hint: "Age",
                        icon1: Icon(Icons.calendar_view_day_outlined),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Textfield1(
                        controller: _schoolcontroller,
                        hint: "school",
                        icon1: Icon(Icons.school_outlined),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Textfield1(
                        controller: _phonecontroller,
                        hint: "Phone",
                        icon1: Icon(Icons.phone),
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
