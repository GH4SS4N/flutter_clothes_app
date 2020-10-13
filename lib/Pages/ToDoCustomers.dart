import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Pages/CustomerOrders.dart';
import 'package:flutter_clothes_app/Widgets/OrderCard.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'AddCustomers.dart';

class ToDoCustomers extends StatefulWidget {
  @override
  _ToDoCustmers createState() => _ToDoCustmers();
}

// not finished order page
class _ToDoCustmers extends State<ToDoCustomers> {
  List orders = List();
  List customers = List();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    // fetch all orders
    ParseResponse response = await ParseObject("Orders").getAll();

    // for every order
    response.results.forEach((order) async {
      // fetch the related customer
      ParseResponse response = await order['customerId'].getQuery().query();
      // get the customer from the response
      var customer = response.result[0];

      // Add it to the orders list
      setState(() {
        orders = orders + [order];
        customers = customers + [customer];
      });
    });
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.deepOrangeAccent,
          child: ListView.builder(
            itemBuilder: (context, index) {
              var order = orders[index];
              var customer = customers[index];

              return OrderCard(
                order: order,
                customer: customer,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerOrders(
                        customer: customer,
                        order: order,
                      ),
                    ),
                  );
                },
              );
            },
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
