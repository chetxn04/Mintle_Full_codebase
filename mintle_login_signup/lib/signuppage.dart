// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mintle_login_signup/firebase_auth_services.dart';
import 'package:mintle_login_signup/home.dart';
import 'package:mintle_login_signup/main.dart';
// import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(SignUpPage());
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully created");
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
            'Create your account',
            style: TextStyle(fontFamily: 'DMSans'),
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
                  child: MyCustomBody2(
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      signUp: _signUp),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // void _signUp() async {
    //String firstName = firstNameController.text;
    //String lastName = lastNameController.text;
    //String password = passwordController.text;
    //String email = emailController.text;
  }
}

class MyCustomBody2 extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function signUp;

  const MyCustomBody2({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.signUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 10),
          child: TextField(
            controller: firstNameController,
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
              hintText: 'First Name',
              hintStyle: TextStyle(fontFamily: 'DMSans', fontSize: 17),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
          child: TextField(
            controller: lastNameController,
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
              hintText: 'Last Name',
              hintStyle: TextStyle(fontFamily: 'DMSans', fontSize: 17),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
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
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
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
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
          child: TextButton(
            onPressed: () => signUp(),
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
                EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
              ),
            ),
            child: Text('Create Account'),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Text(
                'Already have an account ??',
                style: TextStyle(fontFamily: 'DMSans'),
              ),
            ),
          ),
        )
      ],
    );
  }
}
