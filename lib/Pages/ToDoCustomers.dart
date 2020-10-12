import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Widgets/CustomerCard.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'AddCustomers.dart';

class ToDoCustomers extends StatefulWidget {
  @override
  _ToDoCustmers createState() => _ToDoCustmers();
}

// not finished order page
class _ToDoCustmers extends State<ToDoCustomers> {
  List orders = List();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    // fetch all orders
    ParseResponse response = await ParseObject("Orders").getAll();

    // for every order
    response.results.forEach((element) async {
      // fetch the related customer
      ParseResponse response = await element['customerId'].getQuery().query();
      // get the customer from the response
      var customer = response.result[0];

      // Create this order data
      var order = {
        'finished': element['finished'],
        'customerName': customer['name'],
        'phoneNumber': customer['phoneNumber']
      };

      // Add it to the orders list
      setState(() {
        orders = orders + [order];
      });
    });
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.deepOrangeAccent,
          child: ListView.builder(
            itemBuilder: (context, index) => CustomerCard(
              customerName: orders[index]['customerName'],
              finished: orders[index]['finished'],
              phoneNumber: orders[index]['phoneNumber'],
              amount: "amount",
              dateCreated: orders[index]['createdAt'].toString(),
              firstPayment: "first payment",
              submitionDate: 'Click Me Please',
            ),
            itemCount: orders.length,
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
