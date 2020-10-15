import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Data/Customer.dart';
import 'package:flutter_clothes_app/Data/Order.dart';
import 'package:flutter_clothes_app/Widgets/CustomerCard.dart';
import 'package:flutter_clothes_app/Widgets/OrderCard.dart';
import 'package:flutter_clothes_app/Widgets/OrderDetails.dart';

class CustomerOrders extends StatefulWidget {
  final Order order;
  final Customer customer;

  CustomerOrders(this.customer, {this.order, Key key}) : super(key: key);

  @override
  _CustomerOrders createState() =>
      _CustomerOrders(order: order, customer: customer);
}

class _CustomerOrders extends State<CustomerOrders> {
  Order order;
  Customer customer;
  List<Order> orders;

  _CustomerOrders({
    @required this.order,
    @required this.customer,
  });

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

  void fetchAllOrders() {
    setState(() {
      orders = List<Order>();
    });
  }

  // returns a list of all this customer's orders
  Widget ordersList() {
    // if no orders were loaded
    if (orders == null) {
      // Get the orders
      fetchAllOrders();
      // TODO: return something else instead of only text
      return Text('Loading orders');
    }

    // show all customer orders
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: orders.length,
      // Create a list of OrderCard
      itemBuilder: (context, index) => OrderCard(
          order: orders[index],
          // when this order is tapped
          onTap: () {
            // View the order
            setState(() {
              order = orders[index];
            });
          }),
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
              child: CustomerCard(customer),
            ),
            Expanded(
              child:
                  // If there is an order to view
                  order != null
                      ?
                      // Show the order
                      SingleChildScrollView(child: OrderDetails(order: order))
                      // else, show the list of all orders
                      : ordersList(),
            )
          ]),
        ),
      ),
    );
    // ),
  }
}
