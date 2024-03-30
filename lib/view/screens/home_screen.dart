import 'package:firebase_studentdata/bloc/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:firebase_studentdata/view/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreenwrapper extends StatelessWidget {
  const Homescreenwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBlocBloc(),
      child: const Homescreen(),
    );
  }
}

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 93, 201, 173),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              Icons.input_rounded,
            ),
            onPressed: () {
              final AuthBlocBlo = BlocProvider.of<AuthBlocBloc>(context);
              AuthBlocBlo.add(LogoutEvent());
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Loginscreenwrapp()),
                  (route) => false);
            },
          )
        ],
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 93, 201, 173),
      ),
      drawer: Drawer(
          width: 250,
          backgroundColor: Colors.grey[200],
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/back.jpg"), opacity: 0.6),
                ),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.transparent),
                  accountName: Text(
                    " username.toString().toUpperCase()",
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(
                    "userData['email']",
                  ),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture:
                      // userData['image'] != null
                      // ? CircleAvatar(
                      //     radius: 30,
                      //     backgroundImage:
                      //         NetworkImage(userData['image']),
                      //   )
                      // :
                      CircleAvatar(
                    child: Icon(Icons.person_3_outlined),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.people_outline_outlined),
                title: const Text(' My users '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_4_outlined),
                title: const Text(' my profile '),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => const Profilepage()));
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text(' settings '),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 180,
                      child: OutlinedButton(
                        onPressed: () async {
                          // await signoutdialoge(context);
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
      body: Column(
        children: [
          Container(
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
                    height: MediaQuery.of(context).size.height * .18,
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 40,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 123, 120, 120),
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
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.82,
                    child: const Column(
                      children: [
                        CircleAvatar(child: Icon(Icons.person_4_outlined,size: 40,),backgroundColor: Colors.black12,
                          radius: 50,
                        ),
                        Text("Shadil"),
                        Text("muhammesjadil@gmail.com")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * .45,
              width: MediaQuery.of(context).size.width,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 130,
                          width: 130,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 187, 229, 218),
                                  child: Icon(Icons.person_2_outlined),
                                ),
                                Text("Profile")
                              ],
                            ),
                          )),
                      SizedBox(
                          height: 130,
                          width: 130,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 187, 229, 218),
                                  child: Icon(Icons.sports),
                                ),
                                Text("Athlets")
                              ],
                            ),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 130,
                          width: 130,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 187, 229, 218),
                                  child: Icon(Icons.graphic_eq),
                                ),
                                Text("Result's")
                              ],
                            ),
                          )),
                      SizedBox(
                          height: 130,
                          width: 130,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 187, 229, 218),
                                  child: Icon(Icons.assignment),
                                ),
                                Text("Projects")
                              ],
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
