import 'package:hive/hive.dart';

part 'transaction_model.g.dart'; // Generated file name

@HiveType(typeId: 0) // HiveType annotation with typeId
class TransactionModel {
  TransactionModel(
      {required this.userId,
      required this.amount,
      required this.type,
      required this.category,
      required this.description,
      required this.dateTime});
  @HiveField(0) // HiveField annotation with index
  late String userId; // Unique user ID associated with the transaction

  @HiveField(1) // HiveField annotation with index
  late double amount;

  @HiveField(2)
  late String type; // Type of transaction (e.g., expense, income)

  @HiveField(3)
  late String category; // Category of the transaction

  @HiveField(4)
  late String description; // Description of the transaction

  @HiveField(5)
  late DateTime dateTime; // Date and time of the transaction
}
