import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Data/Customer.dart';
import 'package:flutter_clothes_app/Data/Order.dart';
import 'package:flutter_clothes_app/Pages/CustomerOrders.dart';
import 'package:flutter_clothes_app/Widgets/OrderCard.dart';

import 'AddCustomers.dart';

// This page shows all orders
class OrdersHome extends StatefulWidget {
  @override
  _OrdersHome createState() => _OrdersHome();
}

class _OrdersHome extends State<OrdersHome> {
  List<Order> orders = List<Order>();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  // Fetch and update the state with orders
  void fetchOrders() {
    /*TODO: make this more performant by getting all orders first
      then querying customers based on an array of customer ids obtained from orders*/
    // fetch orders
    Order.sortedOrdersBuilder()
      // submit query and receive response
      ..query().then((response) {
        setState(() {
          // cast the response list to type of Order
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
                order,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerOrders(
                        customer,
                        order: order,
                        orderUpdated: fetchOrders,
                      ),
                    ),
                  );
                },
                customer: customer,
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
