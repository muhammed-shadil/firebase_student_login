import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_studentdata/firebase_options.dart';
import 'package:firebase_studentdata/view/screens/splashscreen.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const Myapp());
  
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:SplashScreenWrapper(),debugShowCheckedModeBanner: false,);
  }
}