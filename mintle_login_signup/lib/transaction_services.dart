// import 'package:hive/hive.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:mintle_login_signup/boxes.dart';
// import 'package:mintle_login_signup/transaction_model.dart';

// void main() async {
//   await Hive.initFlutter();
//   Hive.registerAdapter(TransactionModelAdapter());
//   transactionsBox = await Hive.openBox<TransactionModel>('transactionBox');
// }

// void saveTransaction(String userId, double amount, String type, String category,
//     String description, DateTime dateTime) async {
//   // Open the Hive box for transactions
//   final transactionsBox = await Hive.openBox<TransactionModel>('transactions');

//   // Create a new transaction object
//   final transaction = TransactionModel()
//     ..userId = userId
//     ..amount = amount
//     ..type = type
//     ..category = category
//     ..description = description
//     ..dateTime = dateTime;

//   // Save the transaction to the box
//   await transactionsBox.add(transaction);
// }
