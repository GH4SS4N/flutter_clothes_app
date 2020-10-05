import 'dart:io';
//import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Widgets/CustomerCard.dart';

//import '../CustomerCard.dart';

//customer iformation page
class CustomerPage extends StatelessWidget {
  String phoneNumber;
  String customerName;
  bool finished;
  CustomerPage(
      {@required this.customerName,
      @required this.phoneNumber,
      @required this.finished});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text('Customer Orders'),
        ),
        body: Container(
          color: Colors.indigoAccent,
          child: ListView.builder(
              itemBuilder: (context, index) => CustomerCard(
                    phoneNumber: phoneNumber,
                    customerName: customerName,
                    finished: finished,
                    showCustomerButton: false,
                  )),
        ));
  }
}