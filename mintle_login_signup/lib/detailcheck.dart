// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mintle_login_signup/details_input_page.dart';
import 'package:mintle_login_signup/home.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
Future<void> doesUserExist(BuildContext context, String email) async {
  try {
    // Use the 'doc' method to specify the document ID as the email
    DocumentReference userDoc = users.doc(email);
    var existingDoc = await userDoc.get();
    if (existingDoc.exists) {
      // Handle the case where the user already exists
      print("User with email $email already exists.");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      // You can update the existing document here if needed
    } else {
      // Add a new user document
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsInputPage(email: email),
        ),
      );
    }
  } catch (e) {
    print('Error adding user data: $e');
    // Handle error appropriately (show a message, allow the user to retry, etc.)
  }
}
