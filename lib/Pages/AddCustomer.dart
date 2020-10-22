import 'package:flutter/material.dart';

//page where we add orders
class AddCustomer extends StatefulWidget {
  @override
  _AddCustomer createState() => _AddCustomer();
}

class _AddCustomer extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Add Customer'),
      ),
      body: Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'this is a new customer >>> what his name ?',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: Colors.green,
                onPressed: () {
                  //TODO: HERE SHOULD BE THE PARSE CALL TO WRITE THE NEW CUTOMER
                },
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text('Add Customer'),
                  ],
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
