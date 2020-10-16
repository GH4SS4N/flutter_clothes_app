import 'package:flutter_clothes_app/Data/Order.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

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

  Future<List<Order>> getOrders() async {
    if (objectId == null) return null;

    QueryBuilder<Order> queryBuilder = QueryBuilder<Order>(Order())
      ..whereMatchesQuery(Order.customerKey, QueryBuilder<Customer>(this));

    ParseResponse response = await queryBuilder.query();

    return response.results as List<Order>;
  }

  @override
  bool operator ==(other) {
    return objectId == other.objectId;
  }

  @override
  int get hashCode => objectId.hashCode;
}
