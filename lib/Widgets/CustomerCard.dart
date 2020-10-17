import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Data/Customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  CustomerCard(this.customer);

  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 100,
      child: Card(
        shadowColor: Colors.black,
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(1.0),
                child: Icon(
                  Icons.account_circle,
                  size: 60,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Customer name :   ' + customer.name),
                Text('Phone number :   ' + customer.phoneNumber)
              ],
            )
          ],
        ),
      ),
    );
  }
}
