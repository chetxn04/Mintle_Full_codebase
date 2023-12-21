// ignore_for_file: avoid_print

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mintle_login_signup/home.dart';
// import 'package:mintle_login_signup/main.dart';
// import 'package:mintle_login_signup/signuppage.dart';

//import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print('Some error occured');
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print('Some error occured');
    }

    return null;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential authResult = await _auth.signInWithCredential(credential);
      User? user = authResult.user;

      return user;
    } catch (e) {
      print('Error during Google Sign-In: $e');
      return null;
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      // Clear existing Facebook session
      await FacebookAuth.instance.logOut();

      // Perform Facebook login
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email'],
      );

      final AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User? user = authResult.user;

      return user;
    } catch (e) {
      print("Facebook sign in failed : $e");
      return null;
    }
  }
}
