import 'package:hive/hive.dart';
import 'package:mintle_login_signup/boxes.dart';
import 'package:mintle_login_signup/transaction_model.dart';

void updateCategoryCasing() async {
  // Open the Hive box containing your transactions
  transactionsBox = await Hive.openBox<TransactionModel>('transactionBox');

  // Iterate over all entries in the box
  for (int i = 0; i < transactionsBox.length; i++) {
    var transaction = transactionsBox.getAt(i);

    // Check if the category name needs to be updated
    if (transaction != null && transaction.category != null) {
      String oldCategory = transaction.category;
      String newCategory = oldCategory.substring(0, 1).toUpperCase() +
          oldCategory.substring(1).toLowerCase();

      // Update the category name if it has changed
      if (newCategory != oldCategory) {
        transaction.category = newCategory;
        transactionsBox.putAt(
            i, transaction); // Save the modified entry back into the Hive box
      }
    }
  }
}
