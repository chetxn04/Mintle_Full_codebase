// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mintle_login_signup/main.dart';
import 'package:mintle_login_signup/signuppage.dart';
// import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double appBarHeight = 250;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Home Page',
            style: TextStyle(fontFamily: 'DMSans', color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        // body: const MyCustomBody(),
        body: Column(
          children: [
            Container(
              height: appBarHeight,
              child: Center(
                child: Image.asset(
                  'assets/Mintle .png',
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                "User Successfully Registered",
                style: TextStyle(color: Colors.white, fontFamily: 'DMSans'),
              ),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                await FacebookAuth.instance.logOut();
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text(
                "Sign Out ",
                style: TextStyle(color: Colors.white, fontFamily: 'DMSans'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
