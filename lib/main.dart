import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery/Screens/Home.dart';
import 'package:food_delivery/Screens/Introduction_Screen/onBoarding_Screen.dart';
import 'package:food_delivery/Screens/auth_Screen/CheckUser.dart';
import 'package:food_delivery/Screens/auth_Screen/forgotPassword.dart';
import 'package:food_delivery/Screens/auth_Screen/login_Screen.dart';
import 'package:food_delivery/Screens/auth_Screen/singup_Screen.dart';
import 'package:food_delivery/Screens/bottomnav.dart';
import 'package:food_delivery/Screens/details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery/Screens/order.dart';
import 'package:food_delivery/Screens/profile.dart';
import 'package:food_delivery/admin/AddItem_Screen.dart';
import 'package:food_delivery/admin/AdminLogIn.dart';
import 'package:food_delivery/admin/HomeAdmin.dart';
import 'firebase_options.dart';

 Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await dotenv.load(fileName: ".env");
 Stripe.publishableKey=dotenv.env["API_Key"]!;
 await Stripe.instance.applySettings();
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
     initialRoute:BottomNav.id,
      routes: {
        Order_Screen.id:(context)=> Order_Screen(),
        AddItem_Screen.id:(context)=>const AddItem_Screen(),
        AdminHome_Screen.id:(context)=>const AdminHome_Screen(),
        LogInAdmin_Screen.id:(context)=> LogInAdmin_Screen(),
        CheckUser.id:(context)=> const CheckUser(),
        ForgotPassword_Screen.id:(context)=> ForgotPassword_Screen(),
        OnBorarding_Screen.id:(context)=>const OnBorarding_Screen(),
        BottomNav.id:(context)=>const BottomNav(),
        Details_Screen.id:(context)=> Details_Screen(name: '0', price: '0', image: '0', detail: '0',),
        Profile_Screen.id:(context)=>const Profile_Screen(),
        SingUp_Screen.id:(context)=> SingUp_Screen(),
        LogIn_Screen.id:(context)=> LogIn_Screen(),
        Home_Screen.id:(context)=> Home_Screen(),

      },
    );
  }
}
