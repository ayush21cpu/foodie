import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/Screens/Introduction_Screen/onBoarding_Screen.dart';
import 'package:food_delivery/Screens/auth_Screen/login_Screen.dart';
import 'package:food_delivery/Screens/bottomnav.dart';

import '../service/sharedPrefe.dart';

class Profile_Screen extends StatefulWidget {
  static const String id = "profile_Screen";

  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  var name, email;

  getSharedPrefe() async {
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
  }

  @override
  void initState() {
    getSharedPrefe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width / 2, 50))),
            ),
            Center(
                heightFactor: 4,
                child: Text(
                  name.toString(),
                  style: BoldNameText.boldNameTextFieldStyle()
                      .copyWith(color: Colors.white, fontSize: 30),
                )),
            const Padding(
              padding: EdgeInsets.only(top: 120.0, bottom: 20),
              child: Center(
                  child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("images/salad2.png"),
              )),
            )
          ]),
          Card(
            margin: const EdgeInsets.only(left: 10, right: 10),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.black),
              title: Text(
                "Name",
                style: TitleText.titleTextFieldStyle(),
              ),
              subtitle: Text(
                name.toString(),
                style: TitleText.titleTextFieldStyle(),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.email, color: Colors.black),
              title: Text(
                "Email",
                style: TitleText.titleTextFieldStyle(),
              ),
              subtitle: Text(
                email.toString(),
                style: TitleText.titleTextFieldStyle(),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.description, color: Colors.black),
              title: Text(
                "Terms and Condition",
                style: TitleText.titleTextFieldStyle(),
              ),
              onTap: () {},
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.delete, color: Colors.black),
              title: Text(
                "Delete Account",
                style: TitleText.titleTextFieldStyle(),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text("Warning"),
                    content: const Text(
                      "If you select Delete, we will delete your account on our server.\n"
                      "Your app data will also be deleted and you won't be able to retrieve it.\n"
                      "Since this is a security-sensitive operation, you will eventually be asked to log in before your account can be deleted.",
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.currentUser!.delete();
                            Navigator.pushReplacementNamed(
                                context, OnBorarding_Screen.id);
                          } catch (e) {
                            // Handle error (e.g., show a Snackbar or a different dialog with the error message)
                            print("Error deleting account: $e");
                          }
                        },
                        child: const Text("Delete"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, BottomNav.id);
                        },
                        child: const Text("Back"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: Text(
                "LogOut",
                style: TitleText.titleTextFieldStyle(),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LogIn_Screen.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
