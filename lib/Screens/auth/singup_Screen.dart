import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Common/widget/TextFormButton.dart';
import 'package:food_delivery/Screens/Home.dart';

import 'login_Screen.dart';

class SingUp_Screen extends StatefulWidget {
  static const String id = "SingUp_Screen";
  SingUp_Screen({super.key});

  @override
  State<SingUp_Screen> createState() => _SingUp_ScreenState();
}

class _SingUp_ScreenState extends State<SingUp_Screen> {
  final _formKey = GlobalKey<FormState>();

  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> registration(String email,String password) async {
    try{
      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, Home_Screen.id);


    }on FirebaseAuthException catch(e){
      print(e.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFff5c30),
                  Color(0xFFe74b1a),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
                    child: Image.asset(
                      "images/logo.png",
                      width: MediaQuery.of(context).size.width / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "SingUp",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormButton(
                                controller: name,
                                hint: "Name",
                                icon: const Icon(Icons.abc),
                                obscureText: false,
                                valid: "Name",
                              ),
                              TextFormButton(
                                controller: email,
                                hint: "Email",
                                icon: const Icon(Icons.email),
                                obscureText: false,
                                valid: "Email",
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
                        const SizedBox(height: 50),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Color(0xFFe74b1a)),
                            foregroundColor: MaterialStatePropertyAll(Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle signup logic here
                              registration(email.text.trim(), password.text.trim());
                            }
                          },
                          child: const Text("SIGN UP"),
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
                      "Already have an account?",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LogIn_Screen.id);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.black,
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
