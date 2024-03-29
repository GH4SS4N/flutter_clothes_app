//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clothes_app/Model/Customer.dart';
import 'package:flutter_clothes_app/Model/Order.dart';

import 'package:flutter_clothes_app/View/Widgets/OrderDetails.dart';

import 'CustomerOrders.dart';

// Search for customers
class SearchCustomer extends StatefulWidget {
  @override
  _SearchCustomer createState() => _SearchCustomer();
}

class _SearchCustomer extends State<SearchCustomer> {
  var phoneNumber;
  final formKey = new GlobalKey<FormState>();

  searchCustomer() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('validation done');
      setState(() {
        print('inside set state');
        Customer.lookup(phoneNumber).then((value) {
          print(value);
          if (value != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerOrders(value as Customer)));
          } else {
            errorDialog(context);
          }
        });
      });

      print('out of set state');
      //if (x != null) {
      //  response.result

      // show customer page with searched number
      // } else {
      //show Alert Dialog( customer does not exect)
//0503459827
      // }
    }
  }

  Future<String> errorDialog(BuildContext context) {
    TextEditingController textController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Wrong number'),
            content: Text(
                "the number you  have enterd does not exect please make sure the customer number is correct"),
            actions: [
              MaterialButton(
                  elevation: 20,
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(textController.text.toString());
                  })
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: formKey,
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
                child: TextFormField(
                  // key: formKey,
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
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onSaved: (val) {
                    setState(() {
                      phoneNumber = val;
                    });
                  },
                  validator: (val) {
                    return val.length == 0
                        ? 'enter a phone number'
                        : val.length != 10
                            ? "a phone number must contain 10 numbers"
                            : val.startsWith('05')
                                ? null
                                : "a phon number must start with 05";
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
                    onPressed: () {
                      searchCustomer();
                    }),
              )
            ],
          ),
        ),
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
