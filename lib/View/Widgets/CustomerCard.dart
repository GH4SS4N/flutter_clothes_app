import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Model/Customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  var pagelistener;

  CustomerCard(this.customer, this.pagelistener);

  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 100,
      child: Card(
        shadowColor: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
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
                    ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                        size: 40,
                        color:
                            pagelistener == null ? Colors.grey : Colors.black,
                      ),
                      Icon(
                        Icons.list,
                        size: 40,
                        color:
                            pagelistener != null ? Colors.grey : Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
