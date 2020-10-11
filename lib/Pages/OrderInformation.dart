//import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Pages/ToDoCustomers.dart';
import 'package:flutter_clothes_app/Widgets/CustomerCard.dart';
import 'package:flutter_clothes_app/Widgets/InfoWidget.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'CustomerPage.dart';

//import '../CustomerPage.dart';
//import '../InfoWidget.dart';

// order page

class OrderInfo extends StatefulWidget {
  bool recipetInWatch = false;
  String customerName;
  String phoneNumber;
  File file;
  int amount;
  int firstPayment;
  DateTime dateCreated;
  DateTime submitionDate;
  bool finished;
  bool fromCustomerPage;

  OrderInfo(
      {@required this.phoneNumber,
      @required this.customerName,
      this.amount,
      this.dateCreated,
      this.file,
      @required this.finished,
      this.firstPayment,
      this.submitionDate,
      this.fromCustomerPage});
  @override
  _OrderInfo createState() => _OrderInfo(
      phoneNumber: phoneNumber, customerName: customerName, finished: finished);
}

class _OrderInfo extends State<OrderInfo> {
  bool recipetInWatch = true;
  String customerName;
  String phoneNumber;
  File file;
  int amount;
  int firstPayment;
  DateTime dateCreated;
  DateTime submitionDate;
  bool finished;
  bool fromCustomerPage;
  _OrderInfo(
      {@required this.phoneNumber,
      @required this.customerName,
      this.amount,
      this.dateCreated,
      this.file,
      @required this.finished,
      this.firstPayment,
      this.submitionDate,
      this.fromCustomerPage});

  void showImage() async {
    // Widget buildImage(ParseFileBase image) {
    //   return FutureBuilder<ParseFileBase>(
    //     future: image.download(),
    //     builder: (BuildContext context, AsyncSnapshot<ParseFileBase> snapshot) {
    //       if (snapshot.hasData) {
    //         if (kIsWeb) {
    //           return Image.memory((snapshot.data as ParseWebFile).file);
    //         } else {
    //           return Image.file((snapshot.data as ParseFile).file);
    //         }
    //       } else {
    //         return CircularProgressIndicator();
    //       }
    //     },
    //   );
    // }
  }
  void changeOrderView() {
    setState(() {
      if (recipetInWatch) {
        recipetInWatch = false;
      } else {
        recipetInWatch = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text('Order Information'),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
          // child: Container(
          //   //width: 200,
          //   color: Colors.brown,
          //   padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          // child: Stack(children: [
          child: Column(children: [
            InkWell(
                onTap: changeOrderView,
                child: CutomerProfileCard(
                    customerName: customerName, phoneNumber: phoneNumber)),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //USER CARD

            recipetInWatch
                ? InfoCard()
                : Container(
                    color: Colors.amber,
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) => CustomerCard(
                              phoneNumber: phoneNumber,
                              customerName: customerName,
                            )),
                  ),
            //   ],
            // ),
            // ),
          ]),
        ),
      ),
      // ),
    );
  }
}

class CutomerProfileCard extends StatelessWidget {
  String customerName;
  String phoneNumber;

  CutomerProfileCard({@required this.customerName, @required this.phoneNumber});

  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        shadowColor: Colors.black,
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(1.0),
                child: Icon(
                  Icons.account_circle,
                  size: 60,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Customer name :   ' + customerName),
                Text('   phone number :   ' + phoneNumber)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  bool recipetInWatch = false;

  int amount;
  int firstPayment;
  DateTime dateCreated;
  DateTime submitionDate;

  InfoCard({
    this.amount,
    this.dateCreated,
    this.firstPayment,
    this.submitionDate,
  });
//Saud parse
//void parseSetsubmitionDate(){};
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  //DEMO OF THE IMAGE VIOW
                  child: Container(
                    child: Icon(Icons.image),
                    height: 360,
                    width: 380,
                    color: Colors.grey,
                  ),
                ),
                //DETAILED INFORMATION ABOUT THE ORDER
                Info(
                  typeOfInfo: "Amount ",
                  info: '$amount',
                ),
                Info(
                  typeOfInfo: "first payment ",
                  info: '$firstPayment',
                ),
                Info(
                  typeOfInfo: "amount left ",
                  info: '{$amount}',
                ),
                Info(
                  typeOfInfo: "date created ",
                  info: '$dateCreated',
                ),
                Info(
                  typeOfInfo: "submetion date ",
                  info: 'xxxxxxxxxx',
                ),
                submitionDate == null
                    ? Card(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(30),
                              child: Text('Finished???'),
                            )
                          ],
                        ),
                      )
                    : Card(
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(30),
                              child: Text(submitionDate.toIso8601String()),
                            )
                          ],
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
