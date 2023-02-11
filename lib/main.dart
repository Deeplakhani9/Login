import 'package:flutter/material.dart';
import 'package:login1/welcom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedVisit = prefs.getBool('isLoggedIn') ?? false;
  bool? isCreatedVisit = prefs.getBool('isSignUp') ?? false;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: (isCreatedVisit == false)
        ? '/'
        : (isLoggedVisit == false)
            ? 'logIn'
            : 'homePage',
    routes: {
      '/': (context) => const MyApp(),
      'logIn': (context) => const LogIn(),
      'homePage': (context) => const HomePage()
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<FormState> createKey = GlobalKey();
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
            key: createKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.flutter_dash_sharp,
                    size: 80,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Create ",
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
                      return "Enter your user name..";
                    }
                    return null;
                  },
                  controller: Global.user2Controller,
                  onSaved: (val) {
                    setState(() {
                      Global.email = Global.user2Controller.text;
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
                  controller: Global.passwordController,
                  onSaved: (val) {
                    setState(() {
                      Global.password = Global.passwordController.text;
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
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isSignUp', true);
                    await prefs.setString(
                        'password', Global.passwordController.text);
                    if (createKey.currentState!.validate()) {
                      createKey.currentState!.save();
                      Navigator.of(context).pushNamed('logIn');
                    }
                  },
                  child: Text("Sign Up"),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(2)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('logIn');
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
