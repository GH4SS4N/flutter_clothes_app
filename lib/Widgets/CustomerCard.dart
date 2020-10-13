import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final String name;
  final String phoneNumber;

  CustomerCard({@required this.name, @required this.phoneNumber});

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
                Text('Customer name :   ' + name),
                Text('Phone number :   ' + phoneNumber)
              ],
            )
          ],
        ),
      ),
    );
  }
}
