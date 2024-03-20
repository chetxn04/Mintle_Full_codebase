// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mintle_login_signup/getuserid.dart';
import 'package:mintle_login_signup/home.dart';
import 'package:mintle_login_signup/keyencoding.dart';
import 'package:mintle_login_signup/transaction_model.dart';
import 'package:mintle_login_signup/userid.dart';
import 'boxes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  transactionsBox = await Hive.openBox<TransactionModel>('transactionBox');
  runApp(transactionApp());
}

Widget _getImageForCategory(String category) {
  if (category == 'Groceries' || category == 'groceries') {
    return Image.asset('images/grocery.png');
  } else if (category == 'Rent' || category == 'rent') {
    return Image.asset('images/rent.png');
  } else if (category == 'Salary' || category == 'salary') {
    return Image.asset('images/salary.png');
  } else if (category == 'Stock Profit' || category == 'stock profit') {
    return Image.asset('images/stock.png');
  } else if (category == 'Dining' || category == 'dining') {
    return Image.asset('images/dining.png');
  } else if (category == 'OTT' || category == 'ott') {
    return Image.asset('images/ott.png');
  } else {
    // Default image or placeholder if category is not matched
    return Image.asset('images/entertainment.png');
  }
}

class transactionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AllTransactionsPage(),
    );
  }
}

class AllTransactionsPage extends StatefulWidget {
  @override
  _AllTransactionsPageState createState() => _AllTransactionsPageState();
}

class _AllTransactionsPageState extends State<AllTransactionsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true; // Prevent default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Transactions',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'DMSans',
              fontSize: 25,
            ),
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF000000),
                Color(0xFF000D39)
              ], // Add your choice of colors here
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Expanded(
                child: ValueListenableBuilder<Box<TransactionModel>>(
                  valueListenable: transactionsBox.listenable(),
                  builder: (context, box, _) {
                    // Get all transactions
                    List<TransactionModel> transactions = box.values.toList();
                    // Sort transactions by date in descending order
                    transactions
                        .sort((a, b) => b.dateTime.compareTo(a.dateTime));
                    return ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (BuildContext context, int index) {
                        TransactionModel transaction = transactions[index];
                        if (transaction.userId == currentUserId) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF14008D),
                            ),
                            child: ListTile(
                              leading: Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  child: _getImageForCategory(
                                      transaction.category),
                                ),
                              ),
                              title: Text(
                                transaction.category,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'DMSans',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17),
                              ),
                              subtitle: Text(
                                transaction.description,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'DMSans',
                                    fontWeight: FontWeight.w100,
                                    fontSize: 13),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${transaction.type == 'Income' ? '+' : '-'}${transaction.amount}',
                                    style: TextStyle(
                                      color: transaction.type == 'Income'
                                          ? Colors.green
                                          : Colors.red,
                                      fontSize: 16,
                                      fontFamily: 'DMSans',
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Flexible(
                                    child: Text(
                                      '${DateFormat('E d\'th\' MMM yyyy').format(transaction.dateTime)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 255, 227, 184)),
                                    ),
                                  ),
                                  Text(
                                    '${DateFormat('HH:mm').format(transaction.dateTime)}',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 227, 184)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
