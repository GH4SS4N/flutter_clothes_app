import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Model/Order.dart';
import 'package:flutter_clothes_app/View/Pages/ImageVeiwer.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class OrderDetails extends StatefulWidget {
  final Order order;
  final Function orderUpdated;

  OrderDetails(this.order, this.orderUpdated);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool _loading = true;

  File imageFile;

  void initState() {
    super.initState();
    downloadImage(widget.order.image).then((downloadedFile) => setState(() {
          imageFile = downloadedFile;
          _loading = false;
        }));
  }

  Future<File> downloadImage(ParseFile parseImage) {
    // if no image was found
    if (parseImage == null) {
      throw new Exception("No image associated with the order!");
    }

    return parseImage
        .download()
        .then((downloadedParseFile) => downloadedParseFile.file);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  // Order image
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageViewer(
                          image: imageFile,
                        ),
                      ),
                    ),
                    child: Container(
                      child: _loading
                          ? Center(
                              child: CircularProgressIndicator(),
                              heightFactor: 0.50,
                              widthFactor: 0.50,
                            )
                          : Image.file(imageFile),
                      height: 360,
                      width: 380,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Divider(color: Colors.black),
                OrderDetail(
                  "Amount ",
                  widget.order.amount.toString() + " SAR",
                ),
                OrderDetail(
                  "First payment ",
                  widget.order.firstPayment.toString() + " SAR",
                ),
                OrderDetail(
                  "Amount left ",
                  (widget.order.amount - widget.order.firstPayment).toString() +
                      " SAR",
                ),
                OrderDetail(
                  "Date created ",
                  DateFormat.yMd().format(widget.order.createdAt),
                ),
                // if the order is updating
                // if the order is completed
                widget.order.finished
                    // show completion date
                    ? Card(
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(30),
                                child: Text(DateFormat.yMd()
                                    .format(widget.order.completedDate)
                                    .toString()))
                          ],
                        ),
                      )
                    // otherwise show button to complete the order
                    : InkWell(
                        child: Card(
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(30),
                                child: Text('Complete'),
                              )
                            ],
                          ),
                        ),
                        // when tapped
                        onTap: () {
                          // update the order
                          widget.order.finished = true;
                          widget.order.completedDate = DateTime.now();
                          // save the new vlues on the server
                          widget.order.save().then((response) {
                            // TODO: implement handling update error(Saud:is it a widget??Ghassan is asking)
                            if (!response.success)
                              print('Could not update object');

                            // stop loading
                            if (this.mounted) setState(() => _loading = true);

                            // notify parent
                            widget.orderUpdated();
                          });
                          // start loading
                          setState(() => _loading = false);
                        },
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OrderDetail extends StatelessWidget {
  final String detailKey;
  final detail;

  OrderDetail(this.detailKey, this.detail);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(detailKey + ":"), Text(detail.toString())],
          ),
          Divider(color: Colors.black),
        ],
      ),
    );
  }
}
