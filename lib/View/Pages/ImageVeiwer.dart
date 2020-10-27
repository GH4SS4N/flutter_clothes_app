import 'dart:convert';
import 'dart:io';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  var image = convertValueToCorrectType(ImageProvider);

  //var imm=;
  ImageViewer({this.image});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRect(
            child: PhotoView(
              imageProvider: image,
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.contained * 4,
              enableRotation: true,
              loadFailedChild: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
