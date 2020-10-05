import 'dart:io';
//import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

//information wedget
class Info extends StatelessWidget {
  String typeOfInfo = '';
  String info = '*';
  Info({@required this.typeOfInfo, this.info});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(typeOfInfo + " :"),
            info == '**'
                ? Container(
                    //color: Colors.amber,
                    height: 25,
                    child: IconButton(
                        icon: Icon(Icons.picture_as_pdf), onPressed: () {}),
                  )
                : Text(info)
          ],
        ),
        Divider(
          color: Colors.black,
        )
      ],
    ));
  }
}
