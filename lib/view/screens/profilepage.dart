import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_studentdata/bloc/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:firebase_studentdata/bloc/imagebloc/bloc/image_bloc.dart';
import 'package:firebase_studentdata/bloc/location_bloc/bloc/fetchlocation_bloc.dart';
import 'package:firebase_studentdata/view/screens/deletedialoge.dart';
import 'package:firebase_studentdata/view/screens/editscreen.dart';
import 'package:firebase_studentdata/view/widgets/listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profilepagewrapper extends StatelessWidget {
  const Profilepagewrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBlocBloc(),
        ),
        BlocProvider(
          create: (context) => FetchlocationBloc(),
        ),
        BlocProvider(
          create: (context) => ImageBloc(),
          child: Container(),
        )
      ],
      child: BlocBuilder<AuthBlocBloc, AuthBlocState>(
        builder: (context, state) {
          return const Profilepage();
        },
      ),
    );
  }
}

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 201, 173),
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("students")
              .doc(user!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final studentData =
                  snapshot.data?.data() as Map<String, dynamic>?;

              if (studentData != null) {
                return BlocBuilder<ImageBloc, ImageState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: (studentData['image'] == null)
                                  ? const CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.person_4_outlined),
                                    )
                                  : (state is Uploadimageloading)
                                      ? const CircleAvatar(
                                          radius: 40,
                                          child: CircularProgressIndicator(),
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              studentData['image']),
                                        ),
                            ),
                            SizedBox(
                              height: 35,
                              child: Text(
                                studentData['username']
                                    .toString()
                                    .toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 30,
                                        top: 17,
                                        bottom: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        .57,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                      children: [
                                        List1(
                                          title: "Email",
                                          subtitle: studentData['email'],
                                          icon:
                                              const Icon(Icons.email_outlined),
                                        ),
                                        List1(
                                          title: "Phone",
                                          subtitle: studentData['phone'],
                                          icon: const Icon(Icons.phone_android),
                                        ),
                                        List1(
                                          title: "Age",
                                          subtitle: studentData['age'],
                                          icon: const Icon(
                                              Icons.calendar_month_outlined),
                                        ),
                                        List1(
                                          title: "School",
                                          subtitle: studentData['school'],
                                          icon: const Icon(Icons.school),
                                        ),
                                        BlocListener<FetchlocationBloc,
                                            FetchlocationState>(
                                          listener: (context, state) {
                                            if (state is LocationLoading) {
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                          child: studentData['location'] == null
                                              ? BlocBuilder<FetchlocationBloc,
                                                  FetchlocationState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is LocationLoading) {
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    } else if (state
                                                        is LocationLoaded) {
                                                      return List1(
                                                        title: "Loction",
                                                        subtitle: studentData[
                                                                'location'] ??
                                                            state.address,
                                                        icon: const Icon(
                                                            Icons.location_on),
                                                      );
                                                    }
                                                    return Container();
                                                  },
                                                )
                                              : List1(
                                                  title: "Location",
                                                  subtitle:
                                                      studentData['location'],
                                                  icon: const Icon(
                                                      Icons.location_on),
                                                ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            BlocProvider.of<FetchlocationBloc>(
                                                    context)
                                                .add(FetchLocation(
                                                    email:
                                                        studentData['email']));
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Fetch Location"),
                                              Icon(Icons.location_on),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const Deletescreenwrapper()));
                                          },
                                          child: const Text("Delete")),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        Editscreenwrapper(
                                                          studentDatas:
                                                              studentData,
                                                        )));
                                          },
                                          child: const Text("Edit")),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
            return Container();
          }),
    );
  }
}
