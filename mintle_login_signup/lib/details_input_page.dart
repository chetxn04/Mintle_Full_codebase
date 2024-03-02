// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
// ignore_for_file: avoid_print
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mintle_login_signup/home.dart';
import 'firebase_auth_services.dart';

class DetailsInputPage extends StatefulWidget {
  final String email;

  const DetailsInputPage({super.key, required this.email});

  @override
  _DetailsInputPageState createState() => _DetailsInputPageState();
}

class _DetailsInputPageState extends State<DetailsInputPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _monthlyBudgetController =
      TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuthService _auth = FirebaseAuthService();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> _addUserData() async {
    try {
      String firstName = _firstNameController.text.trim();
      String lastName = _lastNameController.text.trim();
      double monthlyBudget =
          double.tryParse(_monthlyBudgetController.text) ?? 0;

      // Use the 'doc' method to specify the document ID as the email
      DocumentReference userDoc = users.doc(widget.email);
      var existingDoc = await userDoc.get();
      if (existingDoc.exists) {
        // Handle the case where the user already exists
        print("User with email ${widget.email} already exists.");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        // You can update the existing document here if needed
      } else {
        // Add a new user document
        await userDoc.set({
          'firstName': firstName,
          'lastName': lastName,
          'monthlyBudget': monthlyBudget,
          'spent': 0,
        });
        print("User Added");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } catch (e) {
      print('Error adding user data: $e');
      // Handle error appropriately (show a message, allow the user to retry, etc.)
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '',
            style: TextStyle(fontFamily: 'DMSans', color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        // body: const MyCustomBody(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add your details ...',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white,
                        fontSize: 25),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'First Name',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _firstNameController,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Eg : Chetan',
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w200),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      //contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 102, 0, 192),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Last Name',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _lastNameController,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Eg : Maheshwari',
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w200),
                      //contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 102, 0, 192),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Email ID',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.email,
                    readOnly: true,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      //contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 102, 0, 192),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Budget Allocated',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white,
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _monthlyBudgetController,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Eg : 100000 ',
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w200),
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: Colors.white,
                      ),
                      //contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 102, 0, 192),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        _addUserData();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 95, 0, 191)),
                        foregroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 255, 244, 170)),
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
                          EdgeInsets.symmetric(
                              horizontal: 130.0, vertical: 20.0),
                        ),
                      ),
                      child: Text('Continue'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
