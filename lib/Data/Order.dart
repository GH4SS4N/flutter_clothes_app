import 'package:flutter_clothes_app/Data/Customer.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Order extends ParseObject {
  static const String keyTableName = 'Orders';
  Order() : super(keyTableName);

  @override
  clone(Map map) => Order.clone()..fromJson(map);
  Order.clone() : this();

  static const String finishedKey = 'finished';
  String get finished => get<String>(finishedKey);
  set finished(String finished) => set<String>(finishedKey, finished);

  static const String amountKey = 'amount';
  double get amount => get<double>(amountKey);
  set amount(double amount) => set<double>(amountKey, amount);

  static const String imageKey = 'image';
  ParseFile get image => get<ParseFile>(imageKey);
  set image(ParseFile image) => set<ParseFile>(imageKey, image);

  static const String createdByKey = 'createdBy';
  ParseUser get createdBy => get<ParseUser>(createdByKey);
  set createdBy(ParseUser createdBy) => set<ParseUser>(createdByKey, createdBy);

  static const String firstPaymentKey = 'firstPayment';
  double get firstPayment => get<double>(firstPaymentKey);
  set firstPayment(double firstPayment) =>
      set<double>(firstPaymentKey, firstPayment);

  static const String completedDateKey = 'completedDate';
  DateTime get completedDate => get<DateTime>(completedDateKey);
  set completedDate(DateTime completedDate) =>
      set<DateTime>(completedDateKey, completedDate);

  static const String customerKey = 'customer';
  Customer get customer => get<Customer>(customerKey);
  set customer(Customer customer) => set<Customer>(customerKey, customer);
}
