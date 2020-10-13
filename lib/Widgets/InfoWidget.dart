import 'dart:io';
//import 'dart:ui';

import 'package:flutter/material.dart';

//information wedget
class Info extends StatelessWidget {
  String typeOfInfo = "null";
  String info = "null";
  Info({@required this.typeOfInfo, this.info});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(typeOfInfo + " :"), Text(info)],
        ),
        Divider(
          color: Colors.black,
        )
      ],
    ));
  }
}
