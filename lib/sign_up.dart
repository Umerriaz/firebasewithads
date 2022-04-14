import 'package:firebasewithads/ad_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebasewithads/guest_student_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SignUP extends StatefulWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _SignUPState();
}

final formkey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

AdProvider adprovider = new AdProvider();

String confPW = "";

void toast(String msg) {
  Fluttertoast.showToast(
      msg: msg, // message
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Color.fromARGB(255, 70, 110, 218),
      //timeInSecForIosWeb: 15,
      textColor: Color.fromARGB(255, 8, 0, 0));
} ///////

class _SignUPState extends State<SignUP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: formkey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign-UP",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: TextFormField(
                    controller: emailController,
                    //initialValue: "",
                    autofocus: false,
                    onChanged: (value) => {},
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(fontSize: 13, color: Colors.red),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ("Please Enter Email");
                      } else if (!value.contains("@")) {
                        return ("Please enter a valid E.Mail");
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    controller: passwordController,
                    //initialValue: "",
                    autofocus: false,
                    obscureText: true,
                    onChanged: (value) => {},
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(fontSize: 13, color: Colors.red),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ("Please Enter Password");
                      }

                      return null;
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: TextFormField(
                    //controller: passwordController,
                    //initialValue: "",
                    autofocus: false,
                    obscureText: true,
                    onChanged: (value) => {
                      confPW = passwordController.text.toString(),
                    },
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(fontSize: 13, color: Colors.red),
                    ),
                    validator: (value) {
                      if (value != confPW) {
                        return ("Passwords do not match");
                      }
                      return null;
                    },
                  ),
                ),
                ////////////
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                //// code to register
                                try {
                                  print("trying to create user");
                                  UserCredential userCredential =
                                  await FirebaseAuth
                                      .instance
                                      .createUserWithEmailAndPassword(
                                      email:
                                      emailController.text.trim(),
                                      password: passwordController.text
                                          .trim());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GuestStudentDetails()));
                                  Fluttertoast.showToast(
                                      msg: "User Created", // message
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor:
                                      Color.fromARGB(255, 70, 110, 218),
                                      //timeInSecForIosWeb: 15,
                                      textColor: Color.fromARGB(255, 8, 0, 0));
                                  ////////////////////////////////////////////////////
                                  print(
                                      "Register User success email ${emailController.text.trim()} and password is ${passwordController.text.trim()} ");
                                } on FirebaseAuthException catch (e) {
                                  print(e);
                                  Fluttertoast.showToast(
                                      msg: e.toString().trim(), // message
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      backgroundColor:
                                      Color.fromARGB(255, 70, 110, 218),
                                      //timeInSecForIosWeb: 15,
                                      textColor: Color.fromARGB(255, 8, 0, 0));
                                  ////////////////////////////////////////////////////
                                  if (e.code == 'weak-password') {
                                    print('The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    print(
                                        'The account already exists for that email.');
                                  }
                                } catch (e) {
                                  print(e);
                                }
                                //////////////////////////

                              }
                            },
                            child: Text("Clear")),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 15, 216, 48),
                              shadowColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          child: Text("Guest "),
                          onPressed: () async {
                            print("Login as Guest");

                            ///////
                            ////////toast/////////////////////////////////////////
                            toast("Creating Guest Log-In");
                            ////////////////////////////////////////////////////
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInAnonymously();
                              /////toast/////////////////////////////////////////
                              toast("Guest Log-IN Created");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GuestStudentDetails()));
                            } on FirebaseAuthException catch (e) {
                              print(e);
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e);
                            }

                            ///
                          },
                        ),

                      ]),
                ),
                Container(
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            adprovider.loadRewardad();
                          },
                          child: Text("Load Ad")),
                      ElevatedButton(
                          onPressed: () {
                            adprovider.showRewardad();
                          },
                          child: Text("Watch Ad")),
                      ElevatedButton(
                          onPressed: () {
                            //adprovider.initializeFullpageInterstaticial();
                            @override
                            void initState() {
                              // initialize homepge banner ad that we defined in ad provider
                              Provider.of<AdProvider>(context, listen: false)
                                  .initializeFullpageInterstaticial();
                              super.initState();
                            }







                          },
                          child: Text("Int add")),
                    ],
                  ),
                )

                ///
              ],
            ),
          ),
        ),
        bottomNavigationBar:
        Consumer<AdProvider>(builder: (context, adProvider, child) {
          if (adProvider.ishomepagead) {
            return Container(
              height: adProvider.homepagead.size.height.toDouble(),
              child: AdWidget(ad: adProvider.homepagead),
            );
          } else {
            return Container(
              height: 10,
            );
          }
        }));
  }

  @override
  void initState() {
    // initialize homepge banner ad that we defined in ad provider
    Provider.of<AdProvider>(context, listen: false).intitializeHomepageBanner();
    super.initState();
  }
}

