import 'package:firebase_auth/firebase_auth.dart';

// Function to get the UID of the authenticated user
Future<String?> getUserID() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  if (user != null) {
    return user.uid; // Return the UID if the user is authenticated
  } else {
    return null; // Return null if no user is authenticated
  }
}
