import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingScreen(),
    );
  }
}

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black,Color(0xFF000D39)],
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                Container(

                  width: 400,
                  height: 400,
                  color: Colors.transparent,
                  child: Image(
                    image: AssetImage('images/img2.png'),
                  ),
                ),
                //
                Text(
                  'Planning ahead',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                SizedBox(height: 50.0),
                //
                Text(
                  'Setup your budget for each category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 6.0),

                Text(
                  'so you are in control',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 20.0),
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCircle(false),
                    _buildCircle(true),
                    _buildCircle(false),
                  ],
                ),
                SizedBox(height: 30.0),
                //
                OutlinedButton(
                  onPressed: () {

                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0x3B65F9)),
                    backgroundColor: Color(0xFF0032E4), // Set the background color to white
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    fixedSize: Size(300, 50), //
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(height: 10.0),
                // f) Login Button
                OutlinedButton(
                  onPressed: () {

                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0x3B65F9)),
                    backgroundColor: Color(0xFFFFF3DC), // Set the background color to white
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    fixedSize: Size(300, 50), //
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Color(0xFF7F3DFF), fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircle(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.white : Colors.grey,
      ),
    );
  }
}
