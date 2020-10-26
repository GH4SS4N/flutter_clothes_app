import 'package:flutter_clothes_app/Model/Customer.dart';
import 'package:flutter_clothes_app/Model/Order.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

const debug = true;

const applicationId = "GHOhkmIucHJIhnhqSHVPMgJXpJmKDBCxt2Nn4Bvp";
const parseServerUrl = "https://parseapi.back4app.com/";
const clientKey = "9FRMiSnXcxB2MzJSuRt7jS3v75vrOImvh8WnkZIF";
const masterKey = "7hvm5PaDdxdD0sBqaf2NJCk5q9UnZqu2Xuz018Ur";

class ParseController extends GetxController {
  final connected = false.obs;

  @override
  void onInit() {
    connectParse()
        .then((value) => connected.value = value.hasParseBeenInitialized());
    super.onInit();
  }

  // Establish a connection with Parse server
  Future<Parse> connectParse() {
    return Parse().initialize(
      applicationId,
      parseServerUrl,
      clientKey: clientKey,
      masterKey: masterKey,
      // Register our custom classes
      registeredSubClassMap: <String, ParseObjectConstructor>{
        Order.keyTableName: () => Order(),
        Customer.keyTableName: () => Customer(),
      },
      debug: debug,
    );
  }
}
