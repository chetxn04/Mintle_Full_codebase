// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:mintle_login_signup/adding_transaction.dart';
import 'package:mintle_login_signup/getuserid.dart';
import 'package:mintle_login_signup/past_transactions_page.dart';
import 'package:mintle_login_signup/analytics.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:mintle_login_signup/userid.dart';
import 'financialNews.dart';
import 'loginpage.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}

class ButtonData {
  final String label;
  final String description;
  final Color color;
  final Widget nextPage;
  final String imagePath;
  final Color borderColor;
  ButtonData(this.label, this.description, this.color, this.imagePath,
      this.nextPage, this.borderColor);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // HomePage({super.key});
  int _currentIndex = 0;

  final _controller = LoopPageController(viewportFraction: 0.75);
  final _bottomBarController = NotchBottomBarController();

  @override
  void initState() {
    super.initState();
    _bottomBarController.jumpTo(0);
    _initializeUserID(); // Set the initial selected index
  }

  Future<void> _initializeUserID() async {
    String? userID = await getUserID();
    if (userID != null) {
      setState(() {
        currentUserId = userID;
      });
    } else {
      // Handle the case where no user is authenticated
    }
  }

  final List<ButtonData> buttons = [
    ButtonData(
        "Swipe to know the features of our app",
        "",
        Color.fromARGB(255, 255, 180, 0),
        'assets/goals.png',
        HomePage(),
        Color.fromARGB(255, 204, 143, 0)),
    ButtonData(
        "History",
        "View your past Transactions",
        Color.fromARGB(255, 60, 240, 56),
        'assets/history.png',
        transactionApp(),
        Color.fromARGB(255, 51, 200, 56)),
    ButtonData(
        "Analytics",
        "Notice trends in your expenses",
        Color.fromARGB(255, 255, 180, 0),
        'assets/analytics.png',
        MyApp(),
        Color.fromARGB(255, 204, 143, 0)),
    ButtonData(
        "Renewals ",
        "Add payments to be done monthly",
        Color.fromARGB(255, 255, 128, 128),
        'assets/renewal.png',
        HomePage(),
        Color.fromARGB(255, 210, 105, 105)),
    ButtonData(
        "Voice Update",
        "Try Our new voice transaction feature ",
        Color.fromARGB(255, 102, 0, 255),
        'assets/goals.png',
        HomePage(),
        Color.fromARGB(255, 65, 0, 176)),
    ButtonData(
        "Reminders",
        "Set up frequency of reminders",
        Color.fromARGB(255, 255, 106, 0),
        'assets/reminder.png',
        HomePage(),
        Color.fromARGB(255, 183, 72, 0)),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double appBarHeight = MediaQuery.of(context).size.height * 0.3;
    double leftPadding = MediaQuery.of(context).size.width * 0.05;
    double topPadding = MediaQuery.of(context).size.height * 0.07;
    final iconList = <IconData>[
      Icons.home,
      Icons.search,
      Icons.favorite,
      Icons.person,
    ];
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF000D39),
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
              backgroundColor: Color.fromARGB(255, 255, 223, 162),
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
          activeIndex: _currentIndex,
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
            // Handle tab selection
            setState(() {
              _currentIndex = index;
            });
          },
          // Add animation for changing color smoothly
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF000000), Color(0xFF000D39)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: leftPadding, bottom: screenHeight * 0.04),
                child: FutureBuilder(
                  future: getUserFirstName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error has occurred");
                    } else {
                      String firstName = snapshot.data?.toString() ?? 'User';
                      return Text(
                        'Welcome, $firstName ...',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.07,
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05),
                child: Container(
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF8E58FF), Color(0xFF36FFCF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.04,
                            top: screenHeight * 0.012),
                        child: Text(
                          "Budget Allocated",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'DMSans',
                              fontSize: 18.0),
                        ),
                      ),
                      FutureBuilder(
                        future: getMonthlyBudget(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text("Error has occurred");
                          } else {
                            double budget = snapshot.data?.toDouble() ?? 100;
                            String budgettext = budget.toString();
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: screenWidth * 0.04),
                              child: Text(
                                budgettext,
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.09,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.04),
                        child: Text(
                          "Spent ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'DMSans',
                              fontSize: 18.0),
                        ),
                      ),
                      FutureBuilder(
                        future: getSpent(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LinearProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text("Error has occurred");
                          } else {
                            double budget = snapshot.data?.toDouble() ?? 100;
                            String budgettext = budget.toString();
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: screenWidth * 0.04),
                              child: Text(
                                budgettext,
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.09,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: leftPadding, top: 16),
                child: Text(
                  "Stuff to do",
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.19,
                child: LoopPageView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: 999,
                  itemBuilder: (context, index) {
                    int actualIndex = index % buttons.length;
                    ButtonData buttonData = buttons[actualIndex];

                    if (index == 0) {
                      // Show the last page on the left of the first page
                      actualIndex = buttons.length - 1;
                    } else if (index == buttons.length + 1) {
                      // Show the first page on the right of the last page
                      actualIndex = 0;
                    }

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  buttons[actualIndex].nextPage,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border(
                              bottom: BorderSide(
                                  color: buttonData.borderColor, width: 6),
                              right: BorderSide(
                                  color: buttonData.borderColor, width: 6),
                            ),
                            color: buttonData.color,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        buttonData.label,
                                        style: const TextStyle(
                                            fontFamily: 'Caveat',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        buttonData.description,
                                        style: const TextStyle(
                                            fontFamily: 'Caveat',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  buttonData.imagePath,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: leftPadding, top: 8, bottom: 0),
                child: Text(
                  'Financial News ..',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'DMSans', fontSize: 22),
                ),
              ),
              Container(
                child: FutureBuilder<List<MarketNews>>(
                  future: MarketNewsService().fetchNews(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      List<MarketNews> newsList = snapshot.data ?? [];
                      return Container(
                        height: screenHeight * 0.32,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: newsList.length,
                            itemBuilder: (context, index) {
                              MarketNews news = newsList[index];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 1),
                                child: Card(
                                  elevation: 20,
                                  color: Color.fromARGB(50, 18, 0, 119),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Set border radius
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 21, 0, 65),
                                          Color.fromARGB(255, 60, 0, 170)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                      // border: Border.all(
                                      //   color: Colors.white, // You can adjust the color as needed
                                      //   width: 2.0, // You can adjust the width as needed
                                      // ),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        news.title,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: CircleAvatar(
                                        backgroundColor: Colors.cyanAccent,
                                        backgroundImage:
                                            NetworkImage(news.imageUrl),
                                      ),
                                      subtitle: Text(
                                        news.description,
                                        maxLines: 2,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      // You can display the image using Image.network(news.imageUrl)
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<double> getMonthlyBudget() async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      if (user != null) {
        String email = user.email ?? '';
        DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(email)
                .get();

        double monthlyBudgetDouble = userData['monthlyBudget'] ?? 100.0;
        return monthlyBudgetDouble;
      } else {
        return 101.0;
      }
    } catch (e) {
      print("Error retrieving monthly budget info: $e");
      return 102.0;
    }
  }

  Future<double> getSpent() async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      if (user != null) {
        String email = user.email ?? '';
        DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(email)
                .get();

        int monthlySpentInt = userData['spent'] ?? 100;
        double monthlySpent = monthlySpentInt.toDouble();
        return monthlySpent;
      } else {
        return 101.0;
      }
    } catch (e) {
      print("Error retrieving monthly spent info: $e");
      return 102.0;
    }
  }

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
}
