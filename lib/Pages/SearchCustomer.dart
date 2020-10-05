import 'dart:io';
//import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Widgets/CustomerCard.dart';

//import '../CustomerCard.dart';

//finished customer page
class SearchCustmer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Type the customer Phone number you want to search ',
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: TextField(
              // textDirection: ,
              maxLength: 10,
              maxLengthEnforced: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusColor: Colors.white,
                  labelText: 'Phone Number :',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    //borderRadiu: BorderSide(color:Colors.blue )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    //borderRadius: BorderRadius.all(Radius.circular(30)))),
                  )),
              onChanged: (value) {
                // print(value);
              },
            ),
          ),
          Container(
            width: 200,
            height: 70,
            child: RaisedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search),
                    Text('Searsh Customers'),
                  ],
                ),
                color: Colors.blue,
                onPressed: () {}),
          )
        ],
      ),
    );
  }
}
// ListView.builder(
//           itemBuilder: (context, index) => CustmerCard(
//                 customerName: 'hassan',
//                 phoneNumber: 050,
//                 finished: true,
//                 showCustomerButton: true,
//               )),
