import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Controller/AllOrdersController.dart';
import 'package:flutter_clothes_app/Model/Customer.dart';
import 'package:flutter_clothes_app/Model/Order.dart';
import 'package:flutter_clothes_app/View/Widgets/CustomerCard.dart';
import 'package:flutter_clothes_app/View/Widgets/OrderCard.dart';
import 'package:flutter_clothes_app/View/Widgets/OrderDetails.dart';
import 'package:get/get.dart';

class CustomerOrders extends StatefulWidget {
  final Order order;
  final Customer customer;
  final Function orderUpdated; // run when the order is updated

  CustomerOrders(this.customer, {this.order, this.orderUpdated, Key key})
      : super(key: key);

  @override
  _CustomerOrders createState() => _CustomerOrders(order: order);
}

class _CustomerOrders extends State<CustomerOrders> {
  Order order; // current order
  List<Order> customerOrders; // current customer
  _CustomerOrders({this.order});

  // get all this customer's orders then updates
  void fetchCustomerOrders() {
    widget.customer
        .getOrders()
        .then((orders) => setState(() => customerOrders = orders))
        // TODO: @GH4SS4N handle error on getting orders
        .catchError((error) {});
  }

  // returns a ListView of all this customer's orders
  Widget ordersList() {
    // if no orders were loaded
    if (customerOrders == null) {
      // load them
      fetchCustomerOrders();
      return Center(child: Container(child: CircularProgressIndicator()));
    }

    // otherwise
    // build a list of order cards
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: customerOrders.length,
      // for every order in our customerOrders
      itemBuilder: (context, index) {
        // create an order card
        return OrderCard(
          customerOrders[index],
          // when this orderCard is tapped, show this order's details
          () => setState(() => order = customerOrders[index]),
        );
      },
    );
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
              onTap: () {
                setState(() {
                  order = null;
                });
              },
              child: CustomerCard(widget.customer),
            ),
            Expanded(
              child:
                  // If there is an order to view
                  order != null
                      ?
                      // Show the order
                      SingleChildScrollView(
                          child: OrderDetails(
                            order,
                            widget.orderUpdated,
                          ),
                        )
                      // otherwise, show a list of this customer's orders
                      : ordersList(),
            )
          ]),
        ),
      ),
    );
  }
}
