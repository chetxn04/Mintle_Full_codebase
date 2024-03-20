// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mintle_login_signup/adding_transaction.dart';
import 'package:mintle_login_signup/better_analytics.dart';
import 'package:mintle_login_signup/home.dart';
import 'package:mintle_login_signup/loginpage.dart';
import 'package:mintle_login_signup/past_transactions_page.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    // double appBarHeight = MediaQuery.of(context).size.height * 0.3;
    // double leftPadding = MediaQuery.of(context).size.width * 0.05;
    // double topPadding = MediaQuery.of(context).size.height * 0.07;
    final iconList = <IconData>[
      Icons.home,
      Icons.swap_horiz_outlined,
      Icons.analytics,
      Icons.person,
    ];

    Future<String> getUserFirstName() async {
      User? user = FirebaseAuth.instance.currentUser;
      try {
        if (user != null) {
          String email = user.email ?? '';
          DocumentSnapshot<Map<String, dynamic>> userData =
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(email)
                  .get();

          String firstName = userData['firstName'];
          return firstName;
        } else {
          return 'User';
        }
      } catch (e) {
        print("Error retrieving user data: $e");
        return 'User';
      }
    }

    return MaterialApp(
      home: Scaffold(
        floatingActionButton: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: _currentIndex == 0 ? 70 : 50,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.fromARGB(
                    255, 255, 223, 162), // Set your desired border color
                width: 2.0, // Set the border width
              ),
            ),
            child: FloatingActionButton(
              shape: CircleBorder(),
              backgroundColor: Color.fromARGB(255, 255, 212, 133),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExpensePage()),
                );
                print('FloatingActionButton pressed!');
              },
              child: Icon(
                Icons.add,
                color: Color.fromARGB(255, 24, 0, 110),
                size: 40,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: 3,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 40,
          backgroundColor: Color(0xFF000D39),
          rightCornerRadius: 40,
          height: 70.0,
          iconSize: 28,
          gapWidth: 20,
          inactiveColor: Color.fromARGB(255, 255, 223, 162),
          borderColor: Color(0xFFFFF3DC),
          notchMargin: 5,
          activeColor: const Color.fromARGB(255, 255, 98, 0),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            switch (index) {
              case 0:
                // Navigate to the first page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
                // Navigate to the second page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllTransactionsPage()),
                );
                break;
              case 2:
                // Navigate to the second page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllTransactionsPage()),
                );
                break;
              case 3:
                // Navigate to the second page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
                break;
              // Add cases for other indices if needed
            }
          },
          // Add animation for changing color smoothly
        ),

        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 243, 220, 180),
        appBar: AppBar(
          toolbarHeight: 90.0,
          centerTitle: true,
          title: Text(
            'My Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontFamily: 'DMSans',
            ),
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        // body: const MyCustomBody(),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 0, top: 20),
              height: 170, // Adjust height as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/user5.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: double.infinity,

                //BOX DECO

                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 220, 180),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),

                //COLUMN STARTED
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: 0, top: 10), // Adjust left and top margins
                      child: FutureBuilder(
                        future: getUserFirstName(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error has occurred");
                          } else {
                            String firstName = snapshot.data ??
                                'User'; // Use snapshot.data directly
                            return Container(
                              margin: EdgeInsets.only(left: 0, top: 30),
                              child: Center(
                                child: Text(
                                  "Hi $firstName !!", // Display "Hi" along with the first name
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DMSans',
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),

                    SizedBox(height: 20),

                    //Personal info Button
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(
                          20, 0, 0, 0), // More padding from the left
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_circle_sharp,
                              color: Colors.black,
                              size: 35,
                            ),
                            SizedBox(width: 15),
                            Text(
                              '  Personal Information',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'DMSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Transactions button
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(
                          20, 0, 0, 0), // More padding from the left
                      child: TextButton(
                        onPressed: () {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllTransactionsPage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.swap_horiz_outlined,
                              color: Colors.black,
                              size: 35,
                            ),
                            SizedBox(width: 15),
                            Text(
                              '  Transactions',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'DMSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //My budget button
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(
                          20, 0, 0, 0), // More padding from the left
                      child: TextButton(
                        onPressed: () {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.currency_rupee_outlined,
                              color: Colors.black,
                              size: 35,
                            ),
                            SizedBox(width: 15),
                            Text(
                              '  My Budget',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'DMSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //My analytics button
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(
                          20, 0, 0, 0), // More padding from the left
                      child: TextButton(
                        onPressed: () {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnalyticsApp(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.analytics,
                              color: Colors.black,
                              size: 35,
                            ),
                            SizedBox(width: 15),
                            Text(
                              '  My Analytics',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'DMSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //invite friends button
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(
                          20, 0, 0, 0), // More padding from the left
                      child: TextButton(
                        onPressed: () {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: Colors.black,
                              size: 35,
                            ),
                            SizedBox(width: 15),
                            Text(
                              '  Invite Friends',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'DMSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Logout button
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: TextButton(
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.remove_circle,
                              color: Colors.black,
                              size: 35,
                            ),
                            SizedBox(width: 15),
                            Text(
                              '  Logout',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'DMSans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    SizedBox(height: 50),

                    //The bottom ka icon bar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
