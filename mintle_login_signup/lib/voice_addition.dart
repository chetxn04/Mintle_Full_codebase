// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mintle_login_signup/boxes.dart';
import 'package:mintle_login_signup/getuserid.dart';
import 'package:mintle_login_signup/keyencoding.dart';
import 'package:mintle_login_signup/transaction_model.dart';
import 'package:mintle_login_signup/userid.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  transactionsBox = await Hive.openBox<TransactionModel>('transactionBox');
}

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText = SpeechToText();
  String text = "Hold the button and start speaking";
  var isListening = false;
  late String _userID;

  @override
  void initState() {
    super.initState();
    _initializeUserID(); // Call the function to initialize the user ID
  }

  Future<void> showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Text'),
          content: Text('Is this the correct text?\n"$text"'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform actions on confirmation (e.g., add to database)
                addToDatabase(text);
                Navigator.of(context).pop(); // Close the dialog
                print("clicked succefully");
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _initializeUserID() async {
    String? userID = await getUserID();
    if (userID != null) {
      setState(() {
        _userID = userID;
        // currentUserId = userID;
      });
    } else {
      // Handle the case where no user is authenticated
    }
  }

  void addToDatabase(String text) {
    print("Adding to database");

    List<String> words = text.split(' ');

    if (words.length >= 3 &&
        words[0].toLowerCase() == 'add' &&
        words[2].toLowerCase() == 'towards') {
      String amount = words[1];
      String category = words.sublist(3).join(' ');
      category = category.substring(0, 1).toUpperCase() + category.substring(1);

      print("Amount: $amount, Category: $category");

      // Attempt to add data to the Hive database
      try {
        transactionsBox.put(
          generateKey(currentUserId!),
          TransactionModel(
            userId: _userID,
            amount: double.tryParse(amount) ?? 0.0,
            type: 'Expense',
            category: category,
            description: 'Speech-to-text input',
            dateTime: DateTime.now(),
          ),
        );
        print("Data added to database successfully");
      } catch (e) {
        print("Error adding data to database: $e");
      }
    } else {
      print("Your code is wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Gradient backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: const [
        Color(0xFF000000),
        Color(0xFF000D39),
      ],
    );
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        duration: Duration(milliseconds: 2000),
        glowColor: Color.fromARGB(53, 255, 210, 147),
        glowCount: 3,
        glowRadiusFactor: 0.7,
        repeat: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(onResult: (result) {
                    print("Recognized Words: ${result.recognizedWords}");
                    setState(() {
                      text = result.recognizedWords;
                    });
                  });
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
            showConfirmationDialog();
          },
          child: Container(
            padding: EdgeInsets.all(40),
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 210, 147),
              radius: 35,
              child: Icon(
                Icons.mic,
                color: Color.fromARGB(255, 2, 5, 104),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Speech To Text",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'DMSans',
          ),
        ),
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
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: backgroundGradient),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        // margin: EdgeInsets.only(bottom: 150),
        child: Text(
          "\"" + text + "\"",
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontFamily: 'DMSans',
          ),
        ),
      ),
    );
  }
}
