import 'dart:io';
//import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../Pages/OrderInformation.dart';

// cutomer card widget
class CustomerCard extends StatelessWidget {
  //ParseObject order;

  String customerName;
  String phoneNumber;
  bool finished = false;
  bool showCustomerButton = true;
  CustomerCard(
      {@required this.phoneNumber,
      @required this.customerName,
      this.finished,
      this.showCustomerButton});

  //CustomerCard({@required this.order})

  Widget build(BuildContext context) {
    // ParseObject("DietPlan").getAll();
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderInfo(
              phoneNumber: this.phoneNumber,
              customerName: this.customerName,
              finished: this.finished,
              fromCustomerPage: showCustomerButton,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 8, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Customer name :  ' + customerName),
                  Text('Phone Number   :' + "  $phoneNumber"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(finished
                          ? Icons.assignment_turned_in
                          : Icons.access_alarm),
                      onPressed: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
