import 'package:flutter/material.dart';
import  'package:intl/intl.dart';
void main() {
  runApp(
      ExpensePage()
  );
}

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = 300;

    var dropdownValue;
    var dt= DateTime.now();

    String formatDate(DateTime date) {
      // Define the desired date format
      final DateFormat formatter = DateFormat('dd MMMM yyyy');
      return formatter.format(date);
    }
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          toolbarHeight: 90.0,
          centerTitle: true,
          title: Text(
            'Add Transaction',
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'DMSans',
            ),

          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        // body: const MyCustomBody(),
        body: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Expanded(
                    child: Container(
                      height: 50,

                      padding: EdgeInsets.fromLTRB(
                          15,10,10,0
                      ),
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          formatDate(DateTime(dt.year,dt.month, dt.day)),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'DMSans',
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    ),
                  ),
                  Container(
                    margin:EdgeInsets.all(10),
                    padding: EdgeInsets.fromLTRB(
                       15,10,5,0
                    ),
                    height: 50,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        DateFormat("hh:mm a").format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 2,
                          fontFamily: 'DMSans',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  width: double.infinity,

                //BOX DECO

                decoration: BoxDecoration(

                  // image:  DecorationImage(
                  //   image: AssetImage('images/bgimg.png'),
                  //   colorFilter: ColorFilter.mode(
                  //       Colors.transparent.withOpacity(0.5),
                  //       BlendMode.dstATop),
                  //
                  //   fit: BoxFit.contain,
                  //   repeat: ImageRepeat.noRepeat,
                  // ),

                  color: Color.fromARGB(255, 243, 220, 180),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),

               //COLUMN STARTED
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>
                      [
                  Container(
                       margin: EdgeInsets.only(left: 30, top: 30), // Adjust left and top margins
                      child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the top
                       children: [
                         Text(
                          "How much?",
                          style: TextStyle(
                            color: Color(0xFFFF2929),
                            fontSize: 24, // Adjust the font size
                          fontWeight: FontWeight.bold,
                         ),
                       ),
                      ],
                      ),
                  ),

                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            style: TextStyle(
                              color: Color(0xFFFF2929),
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                padding: EdgeInsets.only(left: 10, right: 5),
                                child: Text(
                                  "₹",
                                  style: TextStyle(
                                    color: Color(0xFFFF2929),
                                    fontSize: 60,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),

                        SizedBox(height: 100),




                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          padding: EdgeInsets.all(10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 220, 180),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xFFFF8970)),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFA4A4A4),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              hintText: "Type (Expense or Income)",
                              hintStyle: TextStyle(color: Color(0xFFA4A4A4)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          padding: EdgeInsets.all(10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 220, 180),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xFFFF8970)),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFA4A4A4),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              hintText: "Category",
                              hintStyle: TextStyle(color: Color(0xFFA4A4A4)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          padding: EdgeInsets.all(10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 220, 180),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xFFFF8970)),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFA4A4A4),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              hintText: "Description",
                              hintStyle: TextStyle(color: Color(0xFFA4A4A4)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        OutlinedButton(
                          onPressed: () {
                            // Cancel button functionality
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(0xFFFF8970)),
                            backgroundColor:Color(0xFFFF8970), // Set the background color to white
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            fixedSize: Size(300, 50), // Set the width and height
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),

                        SizedBox(height: 10),

                        OutlinedButton(
                          onPressed: () {
                            // Cancel button functionality
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(0xFFFF8970)),
                            backgroundColor: Colors.white, // Set the background color to white
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            fixedSize: Size(300, 50), // Set the width and height
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Color(0xFFFF8970), fontSize: 18),
                          ),
                        ),
                      ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

