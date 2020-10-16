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
  //Set<Customer> customers = Set<Customer>();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  // Updates the state with all orders and their customers
  void fetchOrders() {
    // objectIds for customers we are currently fetching
    //Set<String> customerIdsToFetch = Set();

    QueryBuilder<Order>(Order())
      ..includeObject([Order.customerKey])
      ..query().then((response) {
        setState(() {
          orders = response.results.cast<Order>();
        });
      });

    /*
    Order()
        // Fetch everything from Order
        .getAll()
        // wait for response
        .then((response) {
          
          QueryBuilder(Customer()).
          Customer()
          // go through every result
          response.results.forEach((order) async {
            // get the order
            Order o = order;
            String customerId = o.customer.objectId;

            // looks up this order's customer in saved customers
            Customer c = customers.lookup(o.customer);

            // if no customer was found
            if (c == null && !customerIdsToFetch.contains(customerId)) {
              // register fetching the customer
              customerIdsToFetch.add(customerId);
              // fetch the customer
              c = (await Customer().getObject(customerId)).results[0];
            }

            // save the new order and its customer
            setState(() => {
              orders += [o],
              customers.add(c),
            });
          });
        });*/
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
              print("printing customer" + order.customer.toString());

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
