import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Data/Order.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class OrderDetails extends StatefulWidget {
  final Order order;
  final Function orderUpdated;

  OrderDetails(this.order, this.orderUpdated);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool _loading = false;

  Widget buildImage(ParseFile image) {
    // if no image was found return an icon
    if (image == null) return Icon(Icons.do_not_disturb);

    // otherwise build a future
    return FutureBuilder<ParseFile>(
      // download the image
      future: image.download(),
      // build the image
      builder: (BuildContext context, AsyncSnapshot<ParseFileBase> snapshot) {
        // if data was downloaded
        return snapshot.hasData
            ?
            // show the image
            Image.file((snapshot.data as ParseFile).file)
            // otherwise show a circular progress indicator
            : Center(
                child: CircularProgressIndicator(),
                heightFactor: 0.50,
                widthFactor: 0.50,
              );
      },
    );
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
                  child: Container(
                    // TODO: implement clicking on the image to expand it(Ghassan)
                    child: buildImage(widget.order.image),
                    height: 360,
                    width: 380,
                    color: Colors.grey,
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
                  widget.order.createdAt.toIso8601String(),
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
                                child:
                                    Text(widget.order.completedDate.toString()))
                          ],
                        ),
                      )
                    // otherwise show button to complete the order
                    : InkWell(
                        child: Card(
                          color: Colors.red,
                          child: _loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                  heightFactor: 0.50,
                                  widthFactor: 0.50,
                                )
                              : Row(
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
                            if (this.mounted) setState(() => _loading = false);

                            // notify parent
                            widget.orderUpdated();
                          });
                          // start loading
                          setState(() => _loading = true);
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
