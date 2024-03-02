import 'package:hive/hive.dart';

void main() async {
  //Hive.init('somePath') -> not needed in browser

  var box = await Hive.openBox('transactions');
  print('ID: ${box.get('userID')}');
}
