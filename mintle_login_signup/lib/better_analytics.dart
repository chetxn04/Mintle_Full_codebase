// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mintle_login_signup/boxes.dart';
import 'package:mintle_login_signup/transaction_model.dart';
import 'package:mintle_login_signup/update_lettering.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  transactionsBox = await Hive.openBox<TransactionModel>('transactionBox');
  updateCategoryCasing();
  runApp(AnalyticsApp());
}

class AnalyticsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Analytics',
            style: TextStyle(color: Colors.white, fontFamily: 'DMSans'),
          ),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
          ),
        ),
        body: AnalyticsPage(),
      ),
    );
  }
}

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  String selectedPeriod = 'Daily'; // Default period selection

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF000000), Color(0xFF000D39)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PeriodButton(
                text: 'Daily',
                selectedPeriod: selectedPeriod,
                onPressed: () {
                  setState(() {
                    selectedPeriod = 'Daily';
                  });
                },
              ),
              PeriodButton(
                text: 'Weekly',
                selectedPeriod: selectedPeriod,
                onPressed: () {
                  setState(() {
                    selectedPeriod = 'Weekly';
                  });
                },
              ),
              PeriodButton(
                text: 'Monthly',
                selectedPeriod: selectedPeriod,
                onPressed: () {
                  setState(() {
                    selectedPeriod = 'Monthly';
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: renderGraph(selectedPeriod),
          ),
        ],
      ),
    );
  }

  Widget renderGraph(String period) {
    switch (period) {
      case 'Daily':
        return DailyGraph();
      case 'Weekly':
        return WeeklyGraph();
      case 'Monthly':
        return MonthlyGraph();
      default:
        return Container();
    }
  }
}

class PeriodButton extends StatelessWidget {
  final String text;
  final String selectedPeriod;
  final VoidCallback onPressed;

  const PeriodButton({
    Key? key,
    required this.text,
    required this.selectedPeriod,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return selectedPeriod == text
                ? Color.fromARGB(255, 255, 229, 159)
                : Colors.transparent; // Background color when not selected
          }
          return selectedPeriod == text
              ? Color.fromARGB(255, 255, 229, 159)
              : Colors.transparent; // Background color when not selected
        }),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            side: BorderSide(
              color: selectedPeriod == text
                  ? Colors.transparent
                  : Color.fromARGB(255, 255, 229, 159),
            ),
            borderRadius: BorderRadius.circular(15.0), // Adjust as needed
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selectedPeriod == text
              ? Color.fromARGB(255, 0, 8, 163)
              : Color.fromARGB(
                  255, 255, 229, 159), // Text color based on selection
        ),
      ),
    );
  }
}

class DailyGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    List<TransactionModel> transactions = transactionsBox.values
        .cast<TransactionModel>()
        .where((transaction) =>
            transaction.dateTime.year == selectedDate.year &&
            transaction.dateTime.month == selectedDate.month &&
            transaction.dateTime.day == selectedDate.day &&
            transaction.type == 'Expense')
        .toList();

    // Prepare data for the line chart
    List<FlSpot> lineChartData = [];
    lineChartData.insert(0, FlSpot(0, 0));

    // Prepare data for the pie chart
    Map<String, double> categoryAmounts = {};

    transactions.forEach((transaction) {
      double hour = transaction.dateTime.hour.toDouble();
      double minute = transaction.dateTime.minute.toDouble();
      double time = hour + (minute / 60);

      double amount = transaction.amount.toDouble();
      lineChartData.add(FlSpot(time, amount));

      // Get the lowercase version of the category name
      String lowercaseCategory = transaction.category.toLowerCase();

      // Check if the lowercase category already exists
      if (categoryAmounts.containsKey(lowercaseCategory)) {
        // If it exists, add the amount to the existing category
        categoryAmounts[lowercaseCategory] =
            categoryAmounts[lowercaseCategory]! + transaction.amount;
      } else {
        // If it doesn't exist, create a new entry with the lowercase category
        categoryAmounts[lowercaseCategory] = transaction.amount;
      }
    });

    // Convert the aggregated amounts into pie chart sections
    List<PieChartSectionData> pieChartData =
        categoryAmounts.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.key,
        color: getRandomColor(),
      );
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 300,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 255, 224, 177),
                width: 2.0,
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
                      interval: 1,
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: lineChartData,
                    color: Color(0xFF7F3DFF),
                    isCurved: true,
                    barWidth: 4,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 300,
            width: 400,
            child: PieChart(
              PieChartData(
                sections: pieChartData,
                sectionsSpace: 3,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 200, // Specify a fixed height for the ListView
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryAmounts.length,
              itemBuilder: (context, index) {
                String category = categoryAmounts.keys.elementAt(index);
                double amount = categoryAmounts.values.elementAt(index);
                Color color = pieChartData[index].color!;
                return ListTile(
                  leading: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                  title: Text(
                    category,
                    style: TextStyle(color: Colors.white, fontFamily: 'DMSans'),
                  ),
                  trailing: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '₹',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'DMSans'),
                        ),
                        TextSpan(
                          text: '$amount',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'DMSans'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}

class WeeklyGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime monday = today.subtract(Duration(days: today.weekday - 1));
    DateTime sunday = today.add(Duration(days: 7 - today.weekday));

    List<TransactionModel> transactions = transactionsBox.values
        .cast<TransactionModel>()
        .where((transaction) =>
            transaction.dateTime.isAfter(monday) &&
            transaction.dateTime.isBefore(sunday) &&
            transaction.type == 'Expense')
        .toList();

    List<FlSpot> lineChartData = List.generate(7, (index) {
      DateTime date = monday.add(Duration(days: index));
      double amount = transactions
          .where((transaction) =>
              transaction.dateTime.year == date.year &&
              transaction.dateTime.month == date.month &&
              transaction.dateTime.day == date.day)
          .map((transaction) => transaction.amount.toDouble())
          .fold(0, (prev, amount) => prev + amount);
      return FlSpot(index.toDouble(), amount);
    });

    // Prepare data for the pie chart
    Map<String, double> categoryAmounts = {};

    // Loop through transactions and aggregate amounts for each category
    transactions.forEach((transaction) {
      // Get the lowercase version of the category name
      String lowercaseCategory = transaction.category.toLowerCase();

      // Check if the lowercase category already exists
      if (categoryAmounts.containsKey(lowercaseCategory)) {
        // If it exists, add the amount to the existing category
        categoryAmounts[lowercaseCategory] =
            categoryAmounts[lowercaseCategory]! + transaction.amount;
      } else {
        // If it doesn't exist, create a new entry with the lowercase category
        categoryAmounts[lowercaseCategory] = transaction.amount;
      }
    });

    // Convert the aggregated amounts into pie chart sections
    List<PieChartSectionData> pieChartData =
        categoryAmounts.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.key,
        color: getRandomColor(),
      );
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 300,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 255, 224, 177),
                width: 2.0,
              ),
            ),
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
            padding: EdgeInsets.all(5),
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 6,
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
                      interval: 1,
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: lineChartData,
                    color: Color(0xFF7F3DFF),
                    isCurved: true,
                    barWidth: 4,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 300,
            width: 400,
            child: PieChart(
              PieChartData(
                sections: pieChartData,
                sectionsSpace: 3,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 400, // Specify a fixed height for the ListView
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryAmounts.length,
              itemBuilder: (context, index) {
                String category = categoryAmounts.keys.elementAt(index);
                double amount = categoryAmounts.values.elementAt(index);
                Color color = pieChartData[index].color!;
                return ListTile(
                  leading: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                  title: Text(
                    category,
                    style: TextStyle(color: Colors.white, fontFamily: 'DMSans'),
                  ),
                  trailing: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '₹',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'DMSans'),
                        ),
                        TextSpan(
                          text: '$amount',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'DMSans'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    DateTime today = DateTime.now();
    DateTime currentMonday = today.subtract(Duration(days: today.weekday - 1));
    DateTime previousMonday = currentMonday.subtract(Duration(days: 7));
    DateTime nextSunday = currentMonday.add(Duration(days: 6));

    List<DateTime> weekDays = [];
    for (int i = 0; i < 7; i++) {
      weekDays.add(previousMonday.add(Duration(days: i)));
    }

    DateTime currentDay = weekDays[value.toInt()];
    String abbreviation = getWeekdayAbbreviation(currentDay.weekday);

    return Text(
      abbreviation,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 10,
      ),
    );
  }

  String getWeekdayAbbreviation(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'MON';
      case DateTime.tuesday:
        return 'TUE';
      case DateTime.wednesday:
        return 'WED';
      case DateTime.thursday:
        return 'THU';
      case DateTime.friday:
        return 'FRI';
      case DateTime.saturday:
        return 'SAT';
      case DateTime.sunday:
        return 'SUN';
      default:
        return '';
    }
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
}

class MonthlyGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();

    // Calculate the first day of the current month
    DateTime firstDayOfCurrentMonth = DateTime(now.year, now.month, 1);

    // Calculate the first day of the month for the past 3 months
    List<DateTime> firstDaysOfPastThreeMonths = [];
    for (int i = 2; i >= 0; i--) {
      int year = firstDayOfCurrentMonth.year;
      int month = firstDayOfCurrentMonth.month - i;
      if (month <= 0) {
        month += 12;
        year--;
      }
      int daysInMonth = DateTime(year, month + 1, 0).day;
      firstDaysOfPastThreeMonths.add(DateTime(year, month, 1));
    }

    // Initialize a list to store transactions for the past 3 months
    List<TransactionModel> transactions = [];

    // Loop through transactions and filter transactions for the past 3 months
    transactionsBox.values.cast<TransactionModel>().forEach((transaction) {
      for (DateTime firstDayOfMonth in firstDaysOfPastThreeMonths) {
        if (transaction.dateTime.year == firstDayOfMonth.year &&
            transaction.dateTime.month == firstDayOfMonth.month &&
            transaction.type == 'Expense') {
          transactions.add(transaction);
          break; // Break the loop after adding the transaction for a month
        }
      }
    });

    // Prepare data for the line chart
    List<FlSpot> lineChartData = List.generate(3, (index) {
      DateTime firstDayOfMonth = firstDaysOfPastThreeMonths[index];
      double totalAmount = transactions
          .where((transaction) =>
              transaction.dateTime.year == firstDayOfMonth.year &&
              transaction.dateTime.month == firstDayOfMonth.month)
          .map((transaction) => transaction.amount.toDouble())
          .fold(0, (prev, amount) => prev + amount);
      return FlSpot(index.toDouble(), totalAmount);
    });

    // Prepare data for the pie chart
    Map<String, double> categoryAmounts = {};

    transactions.forEach((transaction) {
      // Get the lowercase version of the category name
      String lowercaseCategory = transaction.category.toLowerCase();

      // Check if the lowercase category already exists
      if (categoryAmounts.containsKey(lowercaseCategory)) {
        // If it exists, add the amount to the existing category
        categoryAmounts[lowercaseCategory] =
            categoryAmounts[lowercaseCategory]! + transaction.amount;
      } else {
        // If it doesn't exist, create a new entry with the lowercase category
        categoryAmounts[lowercaseCategory] = transaction.amount;
      }
    });

    // Convert the aggregated amounts into pie chart sections
    List<PieChartSectionData> pieChartData =
        categoryAmounts.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.key,
        color: getRandomColor(),
      );
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 300,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 255, 224, 177),
                width: 2.0,
              ),
            ),
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
            padding: EdgeInsets.all(5),
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 2,
                minY: 0,
                maxY: 100000,
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
                      interval: 1,
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: lineChartData,
                    color: Color(0xFF7F3DFF),
                    isCurved: true,
                    barWidth: 4,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 300,
            width: 400,
            child: PieChart(
              PieChartData(
                sections: pieChartData,
                sectionsSpace: 3,
              ),
            ),
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: categoryAmounts.length,
            itemBuilder: (context, index) {
              String category = categoryAmounts.keys.elementAt(index);
              double amount = categoryAmounts.values.elementAt(index);
              Color color = pieChartData[index].color!;
              return ListTile(
                leading: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
                title: Text(
                  category,
                  style: TextStyle(color: Colors.white, fontFamily: 'DMSans'),
                ),
                trailing: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '₹',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'DMSans')),
                      TextSpan(
                          text: '$amount',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'DMSans')),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    DateTime today = DateTime.now();
    List<String> monthAbbreviations = [];

    for (int i = 2; i >= 0; i--) {
      DateTime month = DateTime(today.year, today.month - i, 1);
      String abbreviation = getMonthAbbreviation(month.month);
      monthAbbreviations.add(abbreviation);
    }

    int index = value.toInt();
    if (index >= 0 && index < monthAbbreviations.length) {
      return Text(
        monthAbbreviations[index],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 10,
        ),
      );
    } else {
      return SizedBox(); // Return an empty widget if index is out of range
    }
  }

  String getMonthAbbreviation(int month) {
    switch (month) {
      case DateTime.january:
        return 'JAN';
      case DateTime.february:
        return 'FEB';
      case DateTime.march:
        return 'MAR';
      case DateTime.april:
        return 'APR';
      case DateTime.may:
        return 'MAY';
      case DateTime.june:
        return 'JUN';
      case DateTime.july:
        return 'JUL';
      case DateTime.august:
        return 'AUG';
      case DateTime.september:
        return 'SEP';
      case DateTime.october:
        return 'OCT';
      case DateTime.november:
        return 'NOV';
      case DateTime.december:
        return 'DEC';
      default:
        return '';
    }
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
}
