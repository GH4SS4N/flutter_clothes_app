import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clothes_app/Model/Customer.dart';
import 'package:flutter_clothes_app/Model/Order.dart';
import 'package:get/get.dart';

// Add orders
class AddOrder extends StatefulWidget {
  @override
  _AddOrder createState() => _AddOrder();
}

class _AddOrder extends State<AddOrder> {
  var phoneNumber;
  double firstPayment;
  double amount;
  var customerName;
  bool customerDoesExect = false;
  final formKey = new GlobalKey<FormState>();
  File image;
  FilePickerResult result;
  bool isThereAnImage = true;
  bool isTheRestMoreThanAmount = false;

  Future<void> imagegetFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg'],
    );
    if (result != null) {
      //TODO: use file to uploud it to parse (Saud)
      image = File(result.files.single.path);
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

  validatAndSave() async {
    //  bool imageIsStateIsFine = false;
    bool textIsFine = false;
    print('validation---------');
    formKey.currentState.save();
    formKey.currentState.validate();

    if (firstPayment > amount) {
      isTheRestMoreThanAmount = true;
    } else {
      isTheRestMoreThanAmount = false;
    }
    if (image != null) {
      isThereAnImage = true;
    } else {
      isThereAnImage = false;
    }

    if (formKey.currentState.validate()) {
      textIsFine = true;
    }
    print('is there an image ? ' + isThereAnImage.toString());
    print(image.toString());
    print('is the text fine?' + textIsFine.toString());
    if (isThereAnImage && textIsFine) {
      formKey.currentState.save();
      Customer.lookup(phoneNumber).then((value) {
        if (value == null) {
          print('customer does not exicet lets add hem');
          createCustomerDialog(context).then((value) {
            print('inside the dialog');
            customerName = value;
            Customer.addCustomer(phoneNumber, customerName).whenComplete(() {
              print('calling the method agian');
              validatAndSave();
            });
          });
        } else {
          print('order addition');
          Order.addOrder(amount, image, firstPayment, value)
              .whenComplete(() => Navigator.pop(context));
        }
      });
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
                        amount = double.parse(value);
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
                    onSaved: (value) {
                      setState(() {
                        firstPayment = double.parse(value);
                      });
                    },
                    validator: (value) {
                      return value.length == 0
                          ? "there has to be first payment"
                          : isTheRestMoreThanAmount
                              ? "first payment should be less than the total"
                              : null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              icon: Icon(
                                Icons.filter,
                                size: 50,
                                color:
                                    isThereAnImage ? Colors.black : Colors.red,
                              ),
                              onPressed: () {
                                imagegetFile();
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isThereAnImage ? "" : "*choose an image",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
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
