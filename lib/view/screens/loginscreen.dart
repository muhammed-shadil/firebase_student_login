import 'package:firebase_studentdata/bloc/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:firebase_studentdata/view/screens/home_screen.dart';
import 'package:firebase_studentdata/view/screens/signupscreen.dart';
import 'package:firebase_studentdata/view/widgets/button1.dart';
import 'package:firebase_studentdata/view/widgets/loading_indicator.dart';
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

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        final AuthBlocBlo = BlocProvider.of<AuthBlocBloc>(context);
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
                MaterialPageRoute(builder: (_) => Homescreenwrapper()),
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
            child: Column(
              children: [
                SvgPicture.asset("assets/splsh.svg"),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 26),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Textfield1(
                        controller: _emailcontroller,
                        icon1: Icon(Icons.email),
                        hint: "Email",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Textfield1(
                        controller: _passwordcontroller,
                        hint: "Password",
                        icon1: Icon(Icons.lock),
                      ),
                      button1(
                          btntext: "Login",
                          onpressed: () {
                            AuthBlocBlo.add(LoginEvent(
                                email: _emailcontroller.text,
                                password: _passwordcontroller.text));
                          }),
                      const SizedBox(
                        height: 10,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .37,
                            child: const Divider(
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            " OR ",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .37,
                            child: const Divider(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            "assets/4299203.webp",
                            scale: 6,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
        ;
      },
    );
  }
}
