import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Data/Customer.dart';
import 'package:flutter_clothes_app/Data/Order.dart';
import 'package:flutter_clothes_app/Widgets/CustomerCard.dart';
import 'package:flutter_clothes_app/Widgets/OrderCard.dart';
import 'package:flutter_clothes_app/Widgets/OrderDetails.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class CustomerOrders extends StatefulWidget {
  final Order order;
  final Customer customer;
  final Function orderUpdated;

  CustomerOrders(this.customer, {this.order, this.orderUpdated, Key key})
      : super(key: key);

  @override
  _CustomerOrders createState() => _CustomerOrders(order: order);
}

class _CustomerOrders extends State<CustomerOrders> {
  Order order;
  List<Order> customerOrders;

  _CustomerOrders({this.order});

  // requests all orders made by this customer
  void fetchCustomerOrders() {
    Order.sortedOrdersBuilder()
      ..whereContains(Order.customerKey, widget.customer.objectId,
          caseSensitive: true)
      ..whereMatchesQuery("customer", QueryBuilder(widget.customer))
      ..query().then((value) =>
          setState(() => customerOrders = value.results.cast<Order>()));
  }

  // returns a list of all this customer's orders
  Widget ordersList() {
    // if no orders were loaded
    if (customerOrders == null) {
      // Get the orders
      fetchCustomerOrders();
      // TODO: return something else instead of only text
      return Center(child: Container(child: CircularProgressIndicator()));
    }

    // build a list of order cards
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: customerOrders.length,
      // for every order
      itemBuilder: (context, index) {
        // make an order card
        return OrderCard(
          customerOrders[index],
          // when the orderCard is tapped, show the order
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
                        ))
                      // else, show the list of all orders
                      : ordersList(),
            )
          ]),
        ),
      ),
    );
  }
}
