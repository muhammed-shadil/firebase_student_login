import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_studentdata/bloc/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:firebase_studentdata/bloc/notification/notification_serviced.dart';
import 'package:firebase_studentdata/view/screens/loginscreen.dart';
import 'package:firebase_studentdata/view/screens/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreenwrapper extends StatelessWidget {
  const Homescreenwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBlocBloc(),
        child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Sign out"),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
          builder: (context, state) {
            return const Homescreen();
          },
        ));
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  NotificationServices notificationServices = NotificationServices();
  User? user;

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupinteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
      print("token");
      print(value);
    });
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final authBlocBlo = BlocProvider.of<AuthBlocBloc>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.input_rounded,
              ),
              onPressed: () {
                authBlocBlo.add(LogoutEvent());
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const Loginscreenwrapp()),
                    (route) => false);
              },
            )
          ],
          title: const Text(
            "STUwelt",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 93, 201, 173),
        ),
        drawer: Drawer(
            width: 250,
            backgroundColor: Colors.grey[200],
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("students")
                        .doc(user!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        final studentData =
                            snapshot.data?.data() as Map<String, dynamic>?;
                        if (studentData != null) {
                          return DrawerHeader(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/bck.jpeg"),
                                    opacity: 0.6),
                              ),
                              child:
                               Container(
                                decoration: const BoxDecoration(
                                  border: Border(),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    studentData['image'] != null
                                        ? CircleAvatar(
                                            radius: 28,
                                            backgroundImage: NetworkImage(
                                                studentData['image']),
                                          )
                                        : const CircleAvatar(
                                            child:
                                                Icon(Icons.person_4_outlined),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8,),
                                      child: Text(
                                        " ${studentData['username']}"
                                            .toUpperCase(),
                                        style: const TextStyle(fontSize: 16,color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      studentData['email'],style: const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                              // UserAccountsDrawerHeader(
                              //   decoration: const BoxDecoration(border: Border(),
                              //       color: Colors.transparent),
                              //   accountName: Padding(
                              //     padding: const EdgeInsets.only(top: 10),
                              //     child: Text(
                              //       " ${studentData['username']}".toUpperCase(),
                              //       style: const TextStyle(fontSize: 16),
                              //     ),
                              //   ),
                              //   accountEmail: Text(
                              //     studentData['email'],
                              //   ),
                              //   currentAccountPictureSize: const Size.square(40),
                              //   currentAccountPicture: studentData['image'] !=
                              //           null
                              //       ? CircleAvatar(
                              //           radius: 30,
                              //           backgroundImage:
                              //               NetworkImage(studentData['image']),
                              //         )
                              //       : const CircleAvatar(
                              //           child: Icon(Icons.person_3_outlined),
                              //         ),
                              // ),
                              );
                        }
                      }
                      return Container();
                    }),
                ListTile(
                  leading: const Icon(Icons.people_outline_outlined),
                  title: const Text(' Profile '),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Profilepagewrapper()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.sports),
                  title: const Text('Athlets'),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => const Profilepage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.assignment),
                  title: const Text('project'),
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => const Profilepage()));
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .43,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text(" Result's "),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 180,
                        child: OutlinedButton(
                          onPressed: () async {
                            authBlocBlo.add(LogoutEvent());
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Loginscreenwrapp()),
                                (route) => false);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("SIGN OUT "),
                              Icon(Icons.login_outlined)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("students")
                .doc(user!.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                final studentData =
                    snapshot.data?.data() as Map<String, dynamic>?;
                if (studentData != null) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .37,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 93, 201, 173),
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(30),
                                    )),
                                height:
                                    MediaQuery.of(context).size.height * .18,
                              ),
                            ),
                            Positioned(
                              left: 33,
                              top: 40,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 123, 120, 120),
                                        offset: Offset(
                                          0.0,
                                          2.0,
                                        ),
                                        blurRadius: 1.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Color.fromARGB(255, 76, 73, 73),
                                        offset: Offset(0, 2),
                                        blurRadius: 1.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Color.fromARGB(255,199	,249,	204),
                                    color: Colors.white),
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.82,
                                child: Column(
                                  children: [
                                    (studentData['image'] == null)
                                        ? const CircleAvatar(
                                            backgroundColor: Colors.black12,
                                            radius: 50,
                                            child: Icon(
                                              Icons.person_4_outlined,
                                              size: 40,
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                                studentData['image']),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        " ${studentData['username']}"
                                            .toUpperCase(),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Text(studentData['email'])
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .45,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                      height: 130,
                                      width: 130,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const Profilepagewrapper()));
                                        },
                                        child: const Card(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 187, 229, 218),
                                                child: Icon(
                                                    Icons.person_2_outlined),
                                              ),
                                              Text("Profile")
                                            ],
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                      height: 130,
                                      width: 130,
                                      child: GestureDetector(
                                        child: const Card(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 187, 229, 218),
                                                child: Icon(Icons.sports),
                                              ),
                                              Text("Athlets")
                                            ],
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                      height: 130,
                                      width: 130,
                                      child: GestureDetector(
                                        child: const Card(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 187, 229, 218),
                                                child: Icon(Icons.graphic_eq),
                                              ),
                                              Text("Result's")
                                            ],
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                      height: 130,
                                      width: 130,
                                      child: GestureDetector(
                                        child: const Card(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 187, 229, 218),
                                                child: Icon(Icons.assignment),
                                              ),
                                              Text("Projects")
                                            ],
                                          ),
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
              }
              return Container();
            }));
  }
}
