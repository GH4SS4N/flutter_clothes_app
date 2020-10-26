import 'package:flutter_clothes_app/Model/Order.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class AllOrdersController extends GetxController {
  List<Order> orders = List<Order>().obs;

  @override
  void onReady() {
    getAllSorted().then((value) {
      orders.clear();
      orders.addAll(value);
    });
    super.onReady();
  }

  static QueryBuilder<Order> _queryBuilderSorted() {
    return QueryBuilder<Order>(Order())
      // include their customer objects
      ..includeObject([Order.customerKey])
      // order by finished status, from unfinished (0) to finished (1)
      ..orderByAscending(Order.finishedKey)
      // then order by the date created at from most recent to older
      ..orderByDescending('createdAt');
  }

  Future<List<Order>> getAllSorted() async {
    ParseResponse response = await _queryBuilderSorted().query();
    return response.results.cast<Order>();
  }
}
