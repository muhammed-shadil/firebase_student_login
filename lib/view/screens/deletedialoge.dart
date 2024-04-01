import 'package:firebase_studentdata/bloc/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:firebase_studentdata/view/screens/loginscreen.dart';
import 'package:firebase_studentdata/view/widgets/textfield1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Deletescreenwrapper extends StatelessWidget {
  const Deletescreenwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBlocBloc(),
      child: Deletescreen(),
    );
  }
}

class Deletescreen extends StatelessWidget {
  Deletescreen({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final regemail = RegExp(r"^[a-zA-Z0-9_\-\.\S]{4,}[@][a-z]+[\.][a-z]{2,3}$");

  final paswd =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  Widget build(BuildContext context) {
    final authbloc = BlocProvider.of<AuthBlocBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Deleting account"),
      ),
      body: BlocBuilder<AuthBlocBloc, AuthBlocState>(
        builder: (context, state) {
          if (state is Deletedstate) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Loginscreenwrapp()),
                  (route) => false);
            });
          }
          return Container(
            child: Column(
              children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("cancel")),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          authbloc.add(DeletedEvent(
                              email: _emailcontroller.text,
                              password: _passwordcontroller.text));
                        },
                        child: const Text("Delete")),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
