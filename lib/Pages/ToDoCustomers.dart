import 'dart:io';
//import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Widgets/CustomerCard.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

//import '../AddCustomers.dart';
//import '../CustomerCard.dart';
import '../main.dart';
import 'AddCustomers.dart';

class ToDoCustomers extends StatefulWidget {
  @override
  _ToDoCustmers createState() => _ToDoCustmers();
}

// not finished order page
class _ToDoCustmers extends State<ToDoCustomers> {
  @override
  void initState() {
    super.initState();
    print('in');
    //getOrders();
    print('out');
    // writeStudentNames();
    //getStudentNames();
  }

  void getOrders() async {
    var queryBuilder = QueryBuilder<ParseObject>(ParseObject("Orders"))
      ..whereNotEqualTo("submitted_att", null);

    var response = await queryBuilder.query();
    setState(() {
      if (response.success) {
        print(response.result);
      } else {
        print('failed');
      }
    });

    // setState(() {
    //   if (students.success) {
    //     for (var student in students.result) {
    //       print(student['Name']);
    //       newStudentNames.add(student["Name"]);
    //     }

    //     studentNames = newStudentNames;
    //   } else {
    //     print("Failed ya 3ammy");
    //   }
    // };
  }

  Future<Map<ParseObject, ParseObject>> getAllOrders() async {
    var orders = await ParseObject("Orders").getAll();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.deepOrangeAccent,
          child: ListView.builder(
            itemBuilder: (context, index) => CustomerCard(
              customerName: 'Ghassan',
              finished: false,
              phoneNumber: '0504585475',
              showCustomerButton: true,
            ),
            itemCount: 10,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => addCustmer(),
                          ));
                    },
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
