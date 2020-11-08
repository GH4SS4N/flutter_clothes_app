import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Model/Customer.dart';
import 'package:flutter_clothes_app/Model/Order.dart';
import 'package:intl/intl.dart';

// Overview information of an order representing an order record
class OrderCard extends StatelessWidget {
  // order object
  final Order order;
  // customer object
  final Customer customer;
  // function to run when tapped
  final Function onTap;

  OrderCard(this.order, this.onTap, {this.customer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 8, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*TODO: Implement conditional rendering of a customer's info(Saud:is it done?)
              based on whether or not customer is null */
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Created: ' + DateFormat.yMd().format(order.createdAt)),
                    Text('Amount: ' + order.amount.toString())
                  ],
                )
                // Text('Order id: ' + order.objectId),
                ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(order['finished']
                          ? Icons.assignment_turned_in
                          : Icons.access_alarm),
                      onPressed: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
