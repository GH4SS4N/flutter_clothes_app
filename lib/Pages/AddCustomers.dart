import 'dart:io';
//import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

//page where we add orders
class addCustmer extends StatelessWidget {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: TextField(
                  decoration: InputDecoration(labelText: 'Custmer Name :'),
                  onChanged: (value) {
                    // print(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 27),
                child: TextField(
                  maxLength: 10,
                  maxLengthEnforced: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Phone Number :'),
                  onChanged: (value) {
                    // print(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 27),
                child: TextField(
                  // maxLength: 10,
                  // maxLengthEnforced: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'price :'),
                  onChanged: (value) {
                    // print(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 27),
                child: TextField(
                  //selectionWidthStyle: BoxWidthStyle.tight,
                  // maxLength: 10,
                  // maxLengthEnforced: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'first payment :'),
                  onChanged: (value) {
                    // print(value);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.filter),
                      onPressed: () {
                        imagegetFile();
                      }),
                  Text('or'),
                  IconButton(
                      icon: Icon(Icons.picture_as_pdf),
                      onPressed: () {
                        pdfgetFile();
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: RaisedButton(
                        padding: EdgeInsets.all(10),
                        child: Text('ADD'),
                        onPressed: () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
