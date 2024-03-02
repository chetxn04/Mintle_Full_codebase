// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mintle_login_signup/boxes.dart';
import 'package:mintle_login_signup/loginpage.dart';
import 'package:mintle_login_signup/transaction_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  transactionsBox = await Hive.openBox<TransactionModel>('transactionBox');
  runApp(MyApp());
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '',
            style: TextStyle(color: Colors.white, fontFamily: 'DMSans'),
          ),
          backgroundColor: Colors.black,
        ),
        body: AnalyticsPage(),
      ),
    );
  }
}

class AnalyticsPage extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xFF7F3DFF),
    const Color(0xff00071e),
  ];

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    //Code for creating the list which has the
    List<TransactionModel> transactions = transactionsBox.values
        .cast<TransactionModel>()
        .where((transaction) =>
            transaction.dateTime.year == selectedDate.year &&
            transaction.dateTime.month == selectedDate.month &&
            transaction.dateTime.day == selectedDate.day &&
            transaction.type == 'Expense')
        .toList();

    List<FlSpot> data = [];
    data.insert(0, FlSpot(0, 0));

    transactions.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    for (var transaction in transactions) {
      double hour = transaction.dateTime.hour.toDouble();
      double minute = transaction.dateTime.minute.toDouble();
      double time = hour + (minute / 60);

      //Y coordinate
      double amount = transaction.amount.toDouble();
      data.add(FlSpot(time, amount));
    }

    return Center(
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF000000), Color(0xFF000D39)],
          ),
        ),
        child: Column(
          children: [
            Text(
              'Your track record ',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(
                      255, 255, 224, 177), // Choose the cream color
                  width: 2.0, // Adjust the thickness as needed
                ),
              ),
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              padding: EdgeInsets.all(5),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 23,
                  minY: 0,
                  maxY: 10000,
                  titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          // reservedSize: 20,
                          interval: 1,
                          getTitlesWidget: bottomTitleWidgets,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      )),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: Colors.grey,
                        strokeWidth: 0.5,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return const FlLine(
                        color: Colors.grey,
                        strokeWidth: 0.5,
                      );
                    },
                  ),
                  //titlesData: LineTitles.getTitleData(),
                  lineBarsData: [
                    LineChartBarData(
                        spots: data,
                        color: Color(0xFF7F3DFF),
                        isCurved: true,
                        barWidth: 4,
                        //dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF1F1650).withOpacity(0.8),
                              const Color(0xff00071e).withOpacity(0.8),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          // color: Color.fromARGB(255, 148, 95, 255)
                          //     .withOpacity(0.3),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 300,
              width: 300,
              child: PieChart(
                PieChartData(
                  sections: getSections(transactions),
                  sectionsSpace: 3,
                ),
              ),
            ),
            TextButton(
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
              child: const Text(
                "Sign Out ",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'DMSans'),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> getSections(List<TransactionModel> transactions) {
    // Create a map to store aggregated amounts for each category
    Map<String, double> categoryAmounts = {};

    // Aggregate amounts for each category
    transactions.forEach((transaction) {
      if (categoryAmounts.containsKey(transaction.category)) {
        categoryAmounts[transaction.category] =
            (categoryAmounts[transaction.category] ?? 0) +
                transaction.amount.toDouble();
      } else {
        categoryAmounts[transaction.category] = transaction.amount.toDouble();
      }
    });

    // Convert the aggregated amounts into pie chart sections
    return categoryAmounts.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.key,
        color: getRandomColor(),
      );
    }).toList();
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 10,
          ),
        );
        break;
      case 5:
        text = const Text(
          '05:00',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 10,
          ),
        );
        break;
      case 10:
        text = const Text(
          '10:00',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 10,
          ),
        );
        break;
      case 15:
        text = const Text(
          '15:00',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 10,
          ),
        );
        break;
      case 20:
        text = const Text(
          '20:00',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 10,
          ),
        );
        break;
      default:
        text = const Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 10,
          ),
        );
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}
