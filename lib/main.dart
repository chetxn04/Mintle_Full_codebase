import 'package:flutter/material.dart';

void main() {
  runApp(
      ExpensePage()
  );
}

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = 300;

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
                  children: <Widget>
                  [



                    Container(
                      margin: EdgeInsets.only(left: 0, top: 30), // Adjust left and top margins
                      child: Center(
                        child: Text(
                          "User Name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21, // Adjust the font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    //Personal info Button
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(24, 0, 0, 0), // More padding from the left
                      child: TextButton(
                        onPressed: () {

                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_circle_sharp,
                              color: Colors.black,
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Text(
                              '  Personal Information',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
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
                      padding: EdgeInsets.fromLTRB(24, 0, 0, 0), // More padding from the left
                      child: TextButton(
                        onPressed: () {

                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.swap_horiz_outlined,
                              color: Colors.black,
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Text(
                              '  Transactions',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
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
                      padding: EdgeInsets.fromLTRB(24, 0, 0, 0), // More padding from the left
                      child: TextButton(
                        onPressed: () {

                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.currency_rupee_outlined,
                              color: Colors.black,
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Text(
                              '  My Budget',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
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
                      padding: EdgeInsets.fromLTRB(24, 0, 0, 0), // More padding from the left
                      child: TextButton(
                        onPressed: () {

                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.analytics,
                              color: Colors.black,
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Text(
                              '  My Analytics',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
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
                      padding: EdgeInsets.fromLTRB(24, 0, 0, 0), // More padding from the left
                      child: TextButton(
                        onPressed: () {

                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: Colors.black,
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Text(
                              '  Invite Friends',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
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
                      padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                      child: TextButton(
                        onPressed: () {

                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.remove_circle,
                              color: Colors.black,
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Text(
                              '  Logout',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),



                    SizedBox(height: 10),



                    SizedBox(height: 50),

                    //The bottom ka icon bar
                    Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFF010A2C),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: BottomAppBar(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Navigate to home screen
                              },
                              icon: Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.home, color: Colors.white, size: 28),
                              ),
                            ),
                            IconButton(
                              onPressed: () {

                              },
                              icon: Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.call_to_action_sharp, color: Colors.white, size: 28),
                              ),
                            ),
                            IconButton(
                              onPressed: () {

                              },
                              icon: Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.analytics, color: Colors.white, size: 28),
                              ),
                            ),
                            IconButton(
                              onPressed: () {

                              },
                              icon: Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.person, color: Colors.white, size: 28),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )



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

