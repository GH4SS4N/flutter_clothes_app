import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'AddCustomer.dart';

// Add orders
class AddOrder extends StatefulWidget {
  @override
  _AddOrder createState() => _AddOrder();
}

class _AddOrder extends State<AddOrder> {
  var phoneNumber;
  var firstPayment;
  var amount;
  var cutomerName;
  bool customerDoesExect = false;
  final formKey = new GlobalKey<FormState>();
  File file;
  FilePickerResult result;

  Future<void> imagegetFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg'],
    );
    if (result != null) {
      //TODO: use file to uploud it to parse (Saud)
      file = File(result.files.single.path);
    }
  }

  Future<String> createCustomerDialog(BuildContext context) {
    TextEditingController textController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Customer'),
            content: TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s'))
              ],
              decoration: InputDecoration(labelText: 'Cutomer Name'),
              controller: textController,
            ),
            actions: [
              MaterialButton(
                  elevation: 20,
                  child: Text('Add'),
                  onPressed: () {
                    Navigator.of(context).pop(textController.text.toString());
                  })
            ],
          );
        });
  }

  validatAndSave() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(amount.toString() +
          ' ' +
          firstPayment.toString() +
          ' ' +
          phoneNumber.toString());
      //if (there is no cutomer with that phonenumber ){
      createCustomerDialog(context).then((value) {
        cutomerName = value;
      });
      //
      // //TODO: @SaudBako parse call to chick if the customer excest or not and assign the order
      // print("successes");
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    onSaved: (val) {
                      setState(() {
                        phoneNumber = val;
                      });
                    },
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    onSaved: (value) {
                      setState(() {
                        amount = value;
                      });
                    },
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    onSaved: (valu) {
                      setState(() {
                        firstPayment = valu;
                      });
                    },
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
                            onPressed: () {
                              validatAndSave();
                            })),
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
