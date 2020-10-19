import 'dart:io';
//import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/main.dart';

import 'AddCustomer.dart';

//page where we add orders
class AddOrder extends StatefulWidget {
  @override
  _AddOrder createState() => _AddOrder();
}

class _AddOrder extends State<AddOrder> {
  bool customerDoesExect = false;
  final formKey = new GlobalKey<FormState>();
  File file;
  FilePickerResult result;
  // User x =new User(1, 20, 'Ghassan');
  Future<void> pdfgetFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path);
    }
  }

  Future<void> imagegetFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg'],
    );
    if (result != null) {
      File file = File(result.files.single.path);
    }
  }

  validatAndSave() {
    if (formKey.currentState.validate()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddCustomer()));
      //TODO: parse call to chick if the customer excest or not and assign the order
      print("successes");
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Add Custmer'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 27),
                  child: TextFormField(
                    // key: formKey,
                    maxLength: 10,
                    maxLengthEnforced: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Phone Number :'),
                    validator: (val) {
                      return val.length == 0
                          ? 'enter a phone number'
                          : val.length != 10
                              ? "a phone number must contain 10 numbers"
                              : val.startsWith('05')
                                  ? null
                                  : "a phon number must start with 05";
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 27),
                  child: TextFormField(
                    // maxLength: 10,
                    // maxLengthEnforced: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'price :'),
                    validator: (value) {
                      return value.length == 0 ? "fill in the price " : null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 27),
                  child: TextFormField(
                    //selectionWidthStyle: BoxWidthStyle.tight,
                    // maxLength: 10,
                    // maxLengthEnforced: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'first payment :'),
                    validator: (valu) {
                      return valu.length == 0
                          ? "there has to be first payment"
                          : null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.filter,
                          size: 50,
                        ),
                        onPressed: () {
                          imagegetFile();
                        }),
                    // Text('or'),
                    // IconButton(
                    //     icon: Icon(Icons.picture_as_pdf),
                    //     onPressed: () {
                    //       pdfgetFile();
                    //     }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 100, 20, 0),
                        child: RaisedButton(
                          color: Colors.green,
                          //padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text('Add Order'),
                            ],
                          ),
                          onPressed: validatAndSave,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
