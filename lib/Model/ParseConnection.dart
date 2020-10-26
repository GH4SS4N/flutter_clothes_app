import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'Customer.dart';
import 'Order.dart';

const debug = false;

const applicationId = "GHOhkmIucHJIhnhqSHVPMgJXpJmKDBCxt2Nn4Bvp";
const parseServerUrl = "https://parseapi.back4app.com/";
const clientKey = "9FRMiSnXcxB2MzJSuRt7jS3v75vrOImvh8WnkZIF";
const masterKey = "7hvm5PaDdxdD0sBqaf2NJCk5q9UnZqu2Xuz018Ur";

// Establish a connection with Parse server
Future connectParse() {
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
