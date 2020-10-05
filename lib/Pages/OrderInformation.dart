//import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Widgets/InfoWidget.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'CustomerPage.dart';

//import '../CustomerPage.dart';
//import '../InfoWidget.dart';

// order page
class OrderInfo extends StatelessWidget {
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
          padding: const EdgeInsets.all(4.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.account_circle,
                            size: 60,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Customer name :   ' + customerName),
                          Text('   phone number :   ' + phoneNumber)
                        ],
                      )
                    ],
                  ),
                ),
                // Info(
                //   typeOfInfo: "Customer Name",
                //   info: customerName,
                // ),
                // Info(
                //   typeOfInfo: "phone number",
                //   info: '$phoneNumber',
                // ),
                Card(
                  margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Container(
                                child: Icon(Icons.image),
                                height: 360,
                                width: 380,
                                color: Colors.grey,
                              ),
                            ),
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("State :"),
                    this.finished
                        ? Container(
                            //decoration: ShapeDecoration(shape: ShapeBorder.lerp(, b, t),
                            width: 30,
                            height: 30,
                            color: Colors.green,
                            child: Icon(Icons.assignment_turned_in))
                        : Container(
                            //decoration: ShapeDecoration(shape: ShapeBorder.lerp(, b, t),
                            width: 30,
                            height: 30,
                            color: Colors.amber,
                            child: Icon(Icons.access_alarm)),
                  ],
                ),
                Card(
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     fromCustomerPage
                //         ? RaisedButton(
                //             onPressed: () {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) => CustomerPage(
                //                             customerName: customerName,
                //                             finished: finished,
                //                             phoneNumber: phoneNumber,
                //                           )));
                //             },
                //             child: Text('Custmer'),
                //             color: Colors.green,
                //           )
                //         : Text(''),
                //     finished
                //         ? Text('') //  RaisedButton(
                //         //     onPressed: null,
                //         //     child: Text('Finished??'),
                //         //     color: Colors.red,
                //         //   )
                //         : RaisedButton(
                //             onPressed: () {},
                //             child: Text('Finished??'),
                //             color: Colors.red,
                //           ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
