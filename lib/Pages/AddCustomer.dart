import 'package:flutter/material.dart';

//page where we add orders
class AddCustomer extends StatefulWidget {
  @override
  _AddCustomer createState() => _AddCustomer();
}

class _AddCustomer extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Add Customer'),
      ),
      body: Container(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Custmer Name :'),
                onChanged: (value) {
                  // print(value);
                },
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('Add Customer'),
          )
        ],
      )),
    );
  }
}
