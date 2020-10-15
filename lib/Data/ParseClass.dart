import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class ParseClass extends ParseObject {
  ParseClass(String className) : super(className);

  @override
  // Get the ParseObject of the given objectId either from local or server
  Future<ParseResponse> getObject(String objectId) async {
    // retrieves the object from storage
    ParseObject result = await fromPin(objectId);

    // if not found
    if (result == null) {
      print('object of Id ' + objectId + ' not found. Downloading it.');
      // fetch the object
      result =
          await super.getObject(objectId).then((response) => response.result);

      result.pin();
    }

    // return the result in a success response if it exists
    return result == null ? failResponse() : successResponse([result]);
  }

  // fetch all objects, saves them to storage, and returns a ParseResponse
  Future<ParseResponse> getAll() async {
    // fetch all objects
    List<ParseObject> results =
        await getAll().then((response) async => response.results);

    // return a fail response when no results were found
    if (results.isEmpty) return failResponse();

    // save the results
    results.map((result) => result.pin());

    // return a successful response
    return successResponse(results);
  }

  // constructs a success ParseResponse with the results given
  ParseResponse successResponse(List<dynamic> results) {
    ParseResponse response = ParseResponse();
    response.results = [response];
    response.count = results.length;
    response.success = true;
    return response;
  }

  // constructs a not success ParseResponse
  ParseResponse failResponse() {
    ParseResponse response = ParseResponse();
    response.success = false;
    return response;
  }
}
