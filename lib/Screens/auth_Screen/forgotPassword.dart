import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Common/widget/TextFormButton.dart';

class ForgotPassword_Screen extends StatelessWidget {
  static const String id="ForgotPassword_Screen";

  final _formKey = GlobalKey<FormState>();
   ForgotPassword_Screen({super.key});
  @override
  Widget build(BuildContext context) {
    var email=TextEditingController();
    return  Scaffold(
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
                .height / 2.5,
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
            margin: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height / 3),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
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
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      fit: BoxFit.cover,
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
                    height: MediaQuery
        .of(context)
        .size
        .width / 1,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Reset Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 50,),
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
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 90),

                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color(0xFFe74b1a)),
                            foregroundColor: MaterialStatePropertyAll(
                                Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle signup logic here
                              resetPassword(email.text.trim(),);
                            }
                          },
                          child: const Text("Reset Password"),
                        ),
                      ],
                    ),
                  ),
                ),
                  ],
                ),
              ),
            ],
          )
    );
  }

  void resetPassword(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
