import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final order;
  final customer;
  final onTap;

  // If customer is passed, we will show customer info
  // otherwise don't show it
  OrderCard({@required this.order, this.customer, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 8, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //TODO: Implement conditional rendering of a customer's info
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Order id: ' + order['objectId']),
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
