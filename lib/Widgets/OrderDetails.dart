import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  final order;

  OrderDetails({this.order});

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
                  //DEMO OF THE IMAGE VIEW
                  child: Container(
                    child: Icon(Icons.image),
                    height: 360,
                    width: 380,
                    color: Colors.grey,
                  ),
                ),
                //DETAILED INFORMATION ABOUT THE ORDER
                OrderDetail(
                  typeOfInfo: "Amount ",
                  //info: '$amount',
                  info: 'to implement',
                ),
                OrderDetail(
                  typeOfInfo: "first payment ",
                  info: 'to implement',
                ),
                OrderDetail(
                  typeOfInfo: "amount left ",
                  info: 'to implement',
                ),
                OrderDetail(
                  typeOfInfo: "date created ",
                  info: 'to implement',
                ),
                OrderDetail(
                  typeOfInfo: "Submition date ",
                  info: 'to implement',
                ),
                //TODO: check if submission date == null
                null == null
                    ? Card(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(30),
                              child: Text('Submit'),
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
                                child: Text('SUBMISSION DATE')
                                //child: Text(submitionDate.toIso8601String()),
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

class OrderDetail extends StatelessWidget {
  final String typeOfInfo;
  final String info;

  OrderDetail({@required this.typeOfInfo, this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(typeOfInfo + " :"), Text(info)],
        ),
        Divider(
          color: Colors.black,
        )
      ],
    ));
  }
}
