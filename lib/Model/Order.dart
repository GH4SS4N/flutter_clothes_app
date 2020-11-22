import 'dart:io';

import 'package:flutter_clothes_app/Model/Customer.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Order extends ParseObject {
  static const String keyTableName = 'Orders';
  Order() : super(keyTableName);

  @override
  clone(Map map) => Order.clone()..fromJson(map);
  Order.clone() : this();

  static const String finishedKey = 'finished';
  bool get finished => get(finishedKey);
  set finished(bool finished) => set(finishedKey, finished);

  static const String amountKey = 'amount';
  double get amount => double.parse(get(amountKey).toString());
  set amount(double amount) => set(amountKey, amount);

  static const String imageKey = 'image';
  ParseFile get image => get(imageKey);
  set image(ParseFile image) => set(imageKey, image);

  static const String createdByKey = 'createdBy';
  ParseUser get createdBy => get(createdByKey);
  set createdBy(ParseUser createdBy) => set(createdByKey, createdBy);

  static const String firstPaymentKey = 'firstPayment';
  double get firstPayment => double.parse(get(firstPaymentKey).toString());
  set firstPayment(double firstPayment) => set(firstPaymentKey, firstPayment);

  static const String completedDateKey = 'completedDate';
  DateTime get completedDate => get(completedDateKey);
  set completedDate(DateTime completedDate) =>
      set<DateTime>(completedDateKey, completedDate);

  static const String customerKey = 'customer';
  Customer get customer => get(customerKey);
  set customer(Customer customer) => set(customerKey, customer);

  static QueryBuilder<Order> queryBuilderSorted() {
    return QueryBuilder<Order>(Order())
      // include their customer objects
      ..includeObject([Order.customerKey])
      // order by finished status, from unfinished (0) to finished (1)
      ..orderByAscending(Order.finishedKey)
      // then order by the date created at from most recent to older
      ..orderByDescending('createdAt');
  }

  static Future<ParseResponse> getAllSorted() async {
    return queryBuilderSorted().query();
  }

  // Create a new customer with the given data
  // returns true if customer was created successfully
  static Future<bool> addOrder(
      double amount, File image, double firstPayment, Customer customer) async {
    Order newOrder = Order();
    newOrder.amount = amount;
    newOrder.firstPayment = firstPayment;
    newOrder.customer = customer;
    newOrder.image = ParseFile(image)..upload();

    return (await newOrder.save()).success;
  }
}
