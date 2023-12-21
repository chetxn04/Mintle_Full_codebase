// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mintle_login_signup/firebase_auth_services.dart';
import 'package:mintle_login_signup/home.dart';
import 'package:mintle_login_signup/main.dart';
import 'package:mintle_login_signup/signuppage.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase

  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully Signed In");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      print("Some error happened");
    }
  }

  void _signInWithGoogle(BuildContext context) async {
    User? user = await _auth.signInWithGoogle();

    if (user != null) {
      print("User is successfully signed in");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      print("Some error happened");
    }
  }

  void _signInWithFacebook(BuildContext context) async {
    try {
      User? user = await _auth.signInWithFacebook();

      if (user != null) {
        print("User is successfully signed in");

        // Close the Facebook login page
        Navigator.pop(context);

        // Navigate to the HomePage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        print("Some error in Facebook code");
      }
    } catch (e) {
      print("Error during Facebook sign-in: $e");
    }
  }

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
            'Log In',
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
                  'assets/New_logo.png',
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 220, 180),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: MyCustomBody(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    signIn: _signIn,
                    signInWithGoogle: _signInWithGoogle,
                    signInWithFacebook: _signInWithFacebook,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomBody extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function signIn;
  final Function signInWithGoogle;
  final Function signInWithFacebook;

  const MyCustomBody({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.signIn,
    required this.signInWithGoogle,
    required this.signInWithFacebook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 15),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1.2,
                  )),
              hintText: 'Email',
              hintStyle: TextStyle(fontFamily: 'DMSans', fontSize: 17),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                borderSide: BorderSide(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 1.2,
                ),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(fontFamily: 'DMSans', fontSize: 17),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(225, 0, 20, 20),
          child: Text(
            'Recover Password',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: 'DMSans',
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 30),
          child: TextButton(
            onPressed: () => signIn(context),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSans',
                  fontSize: 17,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 140.0, vertical: 20.0),
              ),
            ),
            child: Text('Sign In'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: 120,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Divider(
                  color: Colors.black,
                  thickness: 1.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Text(
                'Or Log In With',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 120,
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Divider(
                  color: Colors.black,
                  thickness: 1.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => signInWithFacebook(context),
              child: Material(
                color: Colors.transparent,
                child: CircleAvatar(
                  radius: 20,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/facebook.png'),
                ),
              ),
            ),
            SizedBox(width: 30),
            InkWell(
              onTap: () => signInWithGoogle(context),
              child: Material(
                color: Colors.transparent,
                child: CircleAvatar(
                  radius: 20,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/google.png'),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpPage(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Text(
                'Don\'t have an account yet !!',
                style: TextStyle(fontFamily: 'DMSans'),
              ),
            ),
          ),
        )
      ],
    );
  }
}
