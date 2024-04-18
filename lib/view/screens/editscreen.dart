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
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _agecontroller = TextEditingController();
  final TextEditingController _schoolcontroller = TextEditingController();

  final phonreg = RegExp(r"^[6789]\d{9}$");
  final paswd =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final name = RegExp(r'^[A-Za-z]+$');
  final age = RegExp(r'^(1[0-9]|[2-9][0-9]|100)$');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: MultiBlocListener(
            listeners: [
              BlocListener<ImageBloc, ImageState>(
                listener: (context, state) {
                  if (state is uploadimagesucces) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Image is uploaded"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is Uploadimagefailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error!!,//${state.msg}"),
                        backgroundColor: Colors.red[300],
                      ),
                    );
                  }
                },
              ),
              BlocListener<AuthBlocBloc, AuthBlocState>(
                listener: (context, state) {
                  if (state is UpdateState) {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Details updated successfully"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is UpdationError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error!!${state.msg}"),
                        backgroundColor: Colors.red[300],
                      ),
                    );
                  }
                },
              ),
            ],
            child: BlocBuilder<ImageBloc, ImageState>(
              builder: (context, state) {
                return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("students")
                        .doc(user.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        final studentData =
                            snapshot.data?.data() as Map<String, dynamic>?;
                        if (studentData != null) {
                          return Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Stack(children: [
                                  (studentData['image'] == null)
                                      ? (state is Uploadimageloading)
                                          ? const CircleAvatar(
                                              radius: 40,
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : const CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 201, 201, 201),
                                              radius: 40,
                                              child:
                                                  Icon(Icons.person_4_outlined),
                                            )
                                      : (state is Uploadimageloading)
                                          ? const CircleAvatar(
                                              radius: 40,
                                              child:
                                                  CircularProgressIndicator(),
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
                                        icon: const Icon(
                                          Icons.add_a_photo_outlined,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Text(
                                      widget.studentDatas['email'],
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 106, 105, 105)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Textfield1(
                                    validator: (value) =>
                                        (value == null || value.isEmpty)
                                            ? "Please enter name"
                                            : (!name.hasMatch(value))
                                                ? "Enter a valid name"
                                                : null,
                                    controller: _namecontroller,
                                    hint: "Name",
                                    icon1: const Icon(Icons.person_4_outlined),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(7.0),
                                //   child: Textfield1(keyboard: TextInputType.emailAddress,
                                //     validator: (value) {
                                //       if (value == null || value.isEmpty) {
                                //         return "Please enter a valid email";
                                //       } else if (!regemail.hasMatch(value)) {
                                //         return "Please enter a valid email";
                                //       } else {
                                //         return null;
                                //       }
                                //     },
                                //     controller: _emailcontroller,
                                //     hint: "Email",
                                //     icon1: const Icon(Icons.email_outlined),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Textfield1(
                                    keyboard: TextInputType.number,
                                    validator: (value) =>
                                        (value == null || value.isEmpty)
                                            ? "Please enter the age"
                                            : (!age.hasMatch(value))
                                                ? "Please enter a valid age"
                                                : null,
                                    controller: _agecontroller,
                                    hint: "Age",
                                    icon1: const Icon(
                                        Icons.calendar_view_day_outlined),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Textfield1(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter schoolname";
                                      } else if (!name.hasMatch(value)) {
                                        return "Enter a valid schoolname";
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
                                  padding: const EdgeInsets.all(7.0),
                                  child: Textfield1(
                                    keyboard: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter phone number";
                                      } else if (value.length > 10) {
                                        return "Number must be 10";
                                      } else if (!phonreg.hasMatch(value)) {
                                        return "Please enter a valid number";
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
                                    if (formKey.currentState!.validate()) {
                                      StudentModel student = StudentModel(
                                          username: _namecontroller.text,
                                          // password: _passwordcontroller.text,
                                          uid: widget.studentDatas['uid'],
                                          image: studentData['image'],
                                          age: _agecontroller.text,
                                          email: widget.studentDatas['email'],
                                          phone: _phonecontroller.text,
                                          location:
                                              widget.studentDatas['location'],
                                          school: _schoolcontroller.text);
                                      authbloc.add(UpdateEvent(user: student));
                                    }
                                  },
                                )
                              ],
                            ),
                          );
                        }
                      }
                      return Container();
                    });
              },
            ),
          ),
        ),
      ),
    );
  }
}
