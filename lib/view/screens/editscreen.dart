import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_studentdata/bloc/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:firebase_studentdata/bloc/imagebloc/bloc/image_bloc.dart';
import 'package:firebase_studentdata/model/student_model.dart';
import 'package:firebase_studentdata/view/screens/profilepage.dart';
import 'package:firebase_studentdata/view/widgets/button1.dart';
import 'package:firebase_studentdata/view/widgets/textfield1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Editscreenwrapper extends StatelessWidget {
  final Map<String, dynamic> studentDatas;
  const Editscreenwrapper({super.key, required this.studentDatas});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBlocBloc(),
        ),
        BlocProvider(
          create: (context) => ImageBloc(),
        ),
      ],
      child: Editscreen(
        studentDatas: studentDatas,
      ),
    );
  }
}

class Editscreen extends StatefulWidget {
  final Map<String, dynamic> studentDatas;
  const Editscreen({super.key, required this.studentDatas});

  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {
  final TextEditingController _emailcontroller = TextEditingController();

  // final TextEditingController _passwordcontroller = TextEditingController();

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

  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    _emailcontroller.text = widget.studentDatas['email'];
    // _passwordcontroller.text = widget.studentDatas['email'];
    _namecontroller.text = widget.studentDatas['username'];
    _phonecontroller.text = widget.studentDatas['phone'];
    _agecontroller.text = widget.studentDatas['age'];
    _schoolcontroller.text = widget.studentDatas['school'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authbloc = BlocProvider.of<AuthBlocBloc>(context);
    final imagbloc = BlocProvider.of<ImageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit",
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthBlocBloc, AuthBlocState>(
        builder: (context, state) {
          if (state is UpdateState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: BlocBuilder<ImageBloc, ImageState>(
                builder: (context, state) {
                  return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("students")
                          .doc(user.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child:
                                  CircularProgressIndicator()); // Show loading indicator while fetching user data
                        }
                        if (snapshot.hasData) {
                          final studentData =
                              snapshot.data?.data() as Map<String, dynamic>?;
                          if (studentData != null) {
                            return Column(
                              children: [
                                Stack(children: [
                                  (widget.studentDatas['image'] == null)
                                      ? const CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 201, 201, 201),
                                          radius: 40,
                                          child: Icon(Icons.person_4_outlined),
                                        )
                                      : CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(
                                              studentData['image']),
                                        ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        onPressed: () {
                                          imagbloc.add(Selectimage(
                                              email: widget
                                                  .studentDatas['email']));
                                        },
                                        icon: Icon(
                                          Icons.add_a_photo_outlined,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
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
                                // Padding(
                                //   padding: EdgeInsets.all(8.0),
                                //   child: Textfield1(
                                //     controller: _passwordcontroller,
                                //     hint: "password",
                                //     icon1: Icon(Icons.class_outlined),
                                //   ),
                                // ),
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
                                    icon1: const Icon(
                                        Icons.calendar_view_day_outlined),
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
                                  btntext: "Update",
                                  onpressed: () {
                                    StudentModel student = StudentModel(
                                        username: _namecontroller.text,
                                        // password: _passwordcontroller.text,
                                        uid: widget.studentDatas['uid'],
                                        image: widget.studentDatas['image'],
                                        age: _agecontroller.text,
                                        email: _emailcontroller.text,
                                        phone: _phonecontroller.text,
                                        school: _schoolcontroller.text);
                                    authbloc.add(UpdateEvent(user: student));
                                  },
                                )
                              ],
                            );
                          }
                        }
                        return Container();
                      });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
