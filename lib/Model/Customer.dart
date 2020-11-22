import 'package:flutter_clothes_app/Model/Order.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

// Custom class for Customer
class Customer extends ParseObject {
  static const String keyTableName = 'Customer';
  Customer() : super(keyTableName);

  @override
  clone(Map map) => Customer.clone()..fromJson(map);
  Customer.clone() : this();

  static const String nameKey = 'name';
  String get name => get<String>(nameKey);
  set name(String name) => set<String>(nameKey, name);

  static const String phoneNumberKey = 'phoneNumber';
  String get phoneNumber => get<String>(phoneNumberKey);
  set phoneNumber(String phoneNumber) =>
      set<String>(phoneNumberKey, phoneNumber);

  // Look up a customer with their phone number
  // returns null if no customer was found
  static Future<Customer> lookup(String phoneNumber) async {
    QueryBuilder<Customer> queryBuilder = QueryBuilder<Customer>(Customer())
      ..whereEqualTo(Customer.phoneNumberKey, phoneNumber);

    ParseResponse response = await queryBuilder.query();

    return response.results == null ? null : response.results[0] as Customer;
  }

  // Fetch all orders associated with this customer
  Future<List<Order>> getOrders() async {
    QueryBuilder<Order> queryBuilder = QueryBuilder<Order>(Order())
      ..whereEqualTo(Order.customerKey, this.objectId);

    return (await queryBuilder.query()).results.cast<Order>();
  }

  // Create a new customer with the given data
  // returns true if customer was created successfully
  static Future<bool> addCustomer(String phoneNumber, String name) async {
    Customer newCustomer = Customer();
    newCustomer.phoneNumber = phoneNumber;
    newCustomer.name = name;

    return (await newCustomer.save()).success;
  }
}

void main() {
  Customer().get("1AdQfymGaF");
}
