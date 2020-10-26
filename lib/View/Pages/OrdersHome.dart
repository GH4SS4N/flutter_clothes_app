import 'package:flutter/material.dart';
import 'package:flutter_clothes_app/Controller/AllOrdersController.dart';
import 'package:flutter_clothes_app/Model/Customer.dart';
import 'package:flutter_clothes_app/Model/Order.dart';
import 'package:flutter_clothes_app/View/Pages/CustomerOrders.dart';
import 'package:flutter_clothes_app/View/Widgets/OrderCard.dart';
import 'package:get/get.dart';

import 'AddOrder.dart';

// This page shows all orders
class OrdersHome extends StatelessWidget {
  final AllOrdersController ordersController = Get.put(AllOrdersController());

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.deepOrangeAccent,
          child: Obx(
            () => ordersController.orders.isEmpty
                ? Center(child: Container(child: CircularProgressIndicator()))
                : ListView.builder(
                    itemBuilder: (context, index) {
                      Order order = ordersController.orders[index];
                      Customer customer = order.customer;
                      return OrderCard(
                        order,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerOrders(
                                customer,
                                order: order,
                              ),
                            ),
                          );
                        },
                        customer: customer,
                      );
                    },
                    itemCount: ordersController.orders.length,
                  ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddOrder(),
                          ));
                    },
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
