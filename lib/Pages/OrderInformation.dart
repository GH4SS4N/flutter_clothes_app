//import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Pages/ToDoCustomers.dart';
import 'package:flutter_clothes_app/Widgets/CustomerCard.dart';
import 'package:flutter_clothes_app/Widgets/InfoWidget.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

//import '../CustomerPage.dart';
//import '../InfoWidget.dart';

// order page

class OrderInfo extends StatefulWidget {
  bool recipetInWatch = false;
  String customerName = "null";
  String phoneNumber = "null";
  File file;
  String amount = "*";
  String firstPayment = "*";
  String dateCreated = "2020-10-04T19:34:09.194Z";
  String submitionDate = "no";
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
      @required this.submitionDate,
      this.fromCustomerPage});
  @override
  _OrderInfo createState() => _OrderInfo(
      phoneNumber: phoneNumber,
      customerName: customerName,
      finished: finished,
      amount: amount,
      dateCreated: dateCreated,
      firstPayment: firstPayment,
      submitionDate: submitionDate);
}

class _OrderInfo extends State<OrderInfo> {
  var itemBuilder = 2;
  bool recipetInWatch = true;
  String customerName = "null";
  String phoneNumber = "null";
  File file;
  String amount = "null";
  String firstPayment = "null";
  String dateCreated = "null";
  String submitionDate = 'null';
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
      @required this.submitionDate,
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
          color: Colors.brown,
          child: Column(children: [
            InkWell(
                onTap: changeOrderView,
                child: CutomerProfileCard(
                  customerName: customerName,
                  phoneNumber: phoneNumber,
                  recipetInWatch: recipetInWatch,
                )),
            Expanded(
              child: recipetInWatch
                  ? SingleChildScrollView(
                      child: InfoCard(
                      amount: amount,
                      dateCreated: dateCreated,
                      firstPayment: firstPayment,
                      submitionDate: submitionDate,
                    ))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              //index information transat to the recipet then go back to the recipet view
                              // dateCreated = order[index]["dateCreated"];
                              // firstPayment = order[index]["firstPayment"];
                              // submitionDate = order[index]["submitionDate"];
                              changeOrderView();
                            },
                            child: Card(
                              margin: EdgeInsets.fromLTRB(10, 8, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('amount :  ' + amount),
                                        Text('date created :' + dateCreated),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            icon: Icon(submitionDate == null
                                                ? Icons.assignment_turned_in
                                                : Icons.access_alarm),
                                            onPressed: () {}),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
            )
          ]),
        ),
      ),
    );
    // ),
  }
}

class CutomerProfileCard extends StatelessWidget {
  String customerName;
  String phoneNumber;
  bool recipetInWatch;

  CutomerProfileCard(
      {@required this.customerName,
      @required this.phoneNumber,
      @required this.recipetInWatch});

  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 100,
      child: Card(
        shadowColor: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Customer name :   ' + customerName),
                    Text('  phone number :   ' + phoneNumber)
                  ],
                ),
              ],
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Icon(Icons.image,
                        size: 25,
                        color: recipetInWatch ? Colors.black : Colors.grey),
                    Icon(Icons.format_align_center,
                        size: 25,
                        color: recipetInWatch ? Colors.grey : Colors.black),
                  ]),
                )
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

  String amount = "null";
  String firstPayment = "null";
  String dateCreated = "null";
  String submitionDate = "non";

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
                  info: amount,
                ),
                Info(
                  typeOfInfo: "first payment ",
                  info: '$firstPayment',
                ),
                Info(
                  typeOfInfo: "amount left ",
                  info: amount,
                ),
                Info(
                  typeOfInfo: "date created ",
                  info: '$dateCreated',
                ),

                submitionDate == null
                    ? InkWell(
                        onTap: () {},
                        child: Card(
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
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          print('fuck Saud');
                        },
                        child: Card(
                          color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(30),
                                child: Text(submitionDate),
                              )
                            ],
                          ),
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
