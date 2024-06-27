import 'package:flutter/material.dart';
import 'package:food_delivery/Screens/Home.dart';
import 'package:food_delivery/Screens/auth/CheckUser.dart';
import 'package:food_delivery/Screens/auth/singup_Screen.dart';

import 'Screens/auth/login_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


 Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     initialRoute: CheckUser.id,
      routes: {
        SingUp_Screen.id:(context)=> SingUp_Screen(),
        LogIn_Screen.id:(context)=> LogIn_Screen(),
        Home_Screen.id:(context)=> Home_Screen(),
        CheckUser.id:(context)=> CheckUser(),
      },
    );
  }
}
