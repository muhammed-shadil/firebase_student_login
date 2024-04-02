import 'package:firebase_studentdata/bloc/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:firebase_studentdata/view/screens/home_screen.dart';
import 'package:firebase_studentdata/view/screens/signupscreen.dart';
import 'package:firebase_studentdata/view/widgets/button1.dart';
import 'package:firebase_studentdata/view/widgets/textfield1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Loginscreenwrapp extends StatelessWidget {
  const Loginscreenwrapp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBlocBloc(),
      child: Loginscreen(),
    );
  }
}

class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  final regemail = RegExp(r"^[a-zA-Z0-9_\-\.\S]{4,}[@][a-z]+[\.][a-z]{2,3}$");

  final paswd =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        final AuthBlocBlo = BlocProvider.of<AuthBlocBloc>(context);
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
              "STUwelt",
              style: TextStyle(fontSize: 15, fontFamily: "assets/font.ttf"),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SvgPicture.asset("assets/splsh.svg"),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 26),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                    child: Column(
                      children: [
                        Textfield1(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter a email";
                            } else if (!regemail.hasMatch(value)) {
                              return "please enter a valid email";
                            } else {
                              return null;
                            }
                          },
                          controller: _emailcontroller,
                          icon1: const Icon(Icons.email),
                          hint: "Email",
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Textfield1(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter a password";
                            } else if (!paswd.hasMatch(value)) {
                              return 'Password should contain at least one upper case, \n one lower case, one digit, one special character and \n must be 8 characters in length';
                            } else {
                              return null;
                            }
                          },
                          controller: _passwordcontroller,
                          hint: "Password",
                          icon1: const Icon(Icons.lock),
                        ),
                        button1(
                            btntext: "Login",
                            onpressed: () {
                              if (formKey.currentState!.validate()) {
                                AuthBlocBlo.add(LoginEvent(
                                    email: _emailcontroller.text,
                                    password: _passwordcontroller.text));
                              }
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have any account"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const SignupscreenWrapper()));
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SizedBox(
                        //       width: MediaQuery.of(context).size.width * .37,
                        //       child: const Divider(
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //     const Text(
                        //       " OR ",
                        //       style: TextStyle(color: Colors.black),
                        //     ),
                        //     SizedBox(
                        //       width: MediaQuery.of(context).size.width * .37,
                        //       child: const Divider(
                        //         color: Colors.black,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // GestureDetector(
                        //     onTap: () {},
                        //     child: Image.asset(
                        //       "assets/4299203.webp",
                        //       scale: 6,
                        //     ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
