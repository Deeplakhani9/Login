import 'package:flutter/material.dart';

import 'global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.green.shade900,
            Colors.orange.shade300,
            Colors.red.shade100,
            Colors.yellow.shade300,
            Colors.blue.shade900,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.flutter_dash_outlined,
                    size: 80,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Welcome ",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 60,
                    color: Colors.black54),
              ),
              Text(
                "back",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    backgroundColor: Colors.white.withOpacity(0.5)),
                onPressed: () {},
                child: Text(
                  "LogIn as  ${Global.user}",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                child: Center(
                    child: Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4, color: Colors.red.withOpacity(0.3))),
                        alignment: Alignment.center,
                        child: Text(
                          "Delete Account",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.red.shade700,
                          ),
                        ))),
                onTap: () {
                  Global.password2Controller.clear();
                  Global.userController.clear();
                  Global.passwordController.clear();
                  Global.user2Controller.clear();
                  Navigator.of(context).pushNamed('/');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
