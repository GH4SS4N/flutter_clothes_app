import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Data/Customer.dart';
import 'package:flutter_clothes_app/Data/Order.dart';
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
  List<Order> orders = List<Order>();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  // Updates the state with all orders and their customers
  void fetchOrders() {
    /*TODO: make this more performant by getting all orders first
      then querying customers based on an array of csutomer ids obtained from orders*/
    QueryBuilder<Order>(Order())
      ..includeObject([Order.customerKey])
      ..query().then((response) {
        setState(() {
          orders = response.results.cast<Order>();
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
              Order order = orders[index];
              Customer customer = order.customer;

              return OrderCard(
                order: order,
                customer: customer,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerOrders(
                        customer,
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
