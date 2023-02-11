import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> loginKey = GlobalKey();

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var emailVal = prefs.getString('email');
    var passwordVal = prefs.getString('password');
    setState(() {
      Global.email = emailVal;
      Global.password = passwordVal;
    });
  }

  String userName = '';
  String obtainedPassword = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.green.shade900,
            Colors.orange.shade300,
            Colors.red.shade100,
            Colors.yellow.shade300,
            Colors.blue.shade900,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Form(
              key: loginKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.flutter_dash,
                        size: 80,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                    Text(
                      "account",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your username..";
                        }
                        return null;
                      },
                      controller: Global.userController,
                      onSaved: (val) {
                        setState(() {
                          userName = Global.userController.text;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: 'user Name',
                          suffixIcon: Icon(Icons.person_outline)),
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your password..";
                        }
                        return null;
                      },
                      controller: Global.password2Controller,
                      onSaved: (val) {
                        setState(() {
                          obtainedPassword = Global.password2Controller.text;
                        });
                      },
                      obscureText: (Global.isActive == false) ? true : false,
                      decoration: InputDecoration(
                          hintText: 'password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                Global.isActive = !Global.isActive;
                              });
                            },
                            icon: (Global.isActive == false)
                                ? Icon(Icons.lock_outline)
                                : Icon(Icons.lock_open),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          backgroundColor: Colors.blue.shade900),
                      onPressed: () async {
                        if (loginKey.currentState!.validate()) {
                          loginKey.currentState!.save();
                          if (Global.email == userName &&
                              Global.password == obtainedPassword) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', true);
                            Navigator.of(context)
                                .pushReplacementNamed('homePage');
                          } else {
                            Navigator.of(context).pushNamed('/');
                          }
                          Global.user = Global.userController.text;
                          print(Global.user);
                        }
                      },
                      child: Text("Sign In"),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/');
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ])),
        ),
      ),
    );
  }
}
