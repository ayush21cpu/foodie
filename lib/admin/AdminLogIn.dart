import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/Common/widget/TextFormButton.dart';
import 'package:food_delivery/Screens/auth_Screen/forgotPassword.dart';
import 'package:food_delivery/Screens/bottomnav.dart';
import 'package:food_delivery/admin/HomeAdmin.dart';
import '../Screens/auth_Screen/singup_Screen.dart';


var logedInUser;

class LogInAdmin_Screen extends StatefulWidget {
  static const String id = "LogInAdmin_Screen";
  LogInAdmin_Screen({super.key});

  @override
  State<LogInAdmin_Screen> createState() => _LogInAdmin_ScreenState();
}

class _LogInAdmin_ScreenState extends State<LogInAdmin_Screen> {

  final _formKey = GlobalKey<FormState>();

  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();

  }

  Adminlogin(String email,String password) async {
    try{
      await FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
        snapshot.docs.forEach((result) {
          if(result.data()['email']!=email.toString().trim()){
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor:Colors.red,content: Text(
               'Your email is not correct',
             )));
          }else if(result.data()['password']!=password.toString().trim()){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor:Colors.red,content: Text(
              'Your password is not correct',
            )));
          }else{
            Navigator.pushReplacementNamed(context, AdminHome_Screen.id);
          }
        });
      });

    }on FirebaseAuthException catch(e){
      e.code.toString();
    }
  }

  void  UserInfo() async {
    try{final user=await FirebaseAuth.instance.currentUser;
    if(user!=null){
      logedInUser=user;
      print(logedInUser.email);

    }
    }catch(e){
      print (e);
    }
  }


  @override
  void initState() {
    super.initState();
    UserInfo();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height ,
            decoration: const BoxDecoration(
              color: Color(0x4E9E9EFF),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height / 2),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration:  BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 53, 51, 51),
                  Colors.black,
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.elliptical(MediaQuery.of(context).size.width, 110.0)
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
                    child: Text(
                      "Let's start with \n Admin",style: BoldText.boldTextFieldStyle().copyWith(fontSize: 30),textAlign: TextAlign.start,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 30, left: 10, right: 10),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.1,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormButton(
                                controller: email,
                                hint: "Email",
                                icon: const Icon(Icons.email),
                                obscureText: false,
                                valid: "Email",
                                TextInputType:TextInputType.emailAddress,
                              ),
                              TextFormButton(
                                controller: password,
                                hint: "Password",
                                icon: const Icon(Icons.password),
                                obscureText: true,
                                valid: "Password",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, ForgotPassword_Screen.id);
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          margin: const EdgeInsets.only(top: 10,bottom: 50),
                          width: MediaQuery.of(context).size.width/1,
                          height: 50,
                          child: ElevatedButton(
                            style:  const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.black),
                              foregroundColor: MaterialStatePropertyAll(
                                  Colors.white),
                              shape: MaterialStatePropertyAll( RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Handle signup logic here
                                Adminlogin(email.text.trim(), password.text.trim());

                              }
                            },
                            child: const Text("LogIn",style:TextStyle(fontSize: 20),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account?",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700,color: Colors.white60),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SingUp_Screen.id);
                      },
                      child: const Text(
                        "Sing Up",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


