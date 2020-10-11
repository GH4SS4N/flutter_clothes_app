import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'Pages/SearchCustomer.dart';
import 'Pages/ToDoCustomers.dart';

void main() {
  runApp(MyApp());
}

const applicationId = "GHOhkmIucHJIhnhqSHVPMgJXpJmKDBCxt2Nn4Bvp";
const parseServerUrl = "https://parseapi.back4app.com/";
const clientKey = "9FRMiSnXcxB2MzJSuRt7jS3v75vrOImvh8WnkZIF";
const masterKey = "7hvm5PaDdxdD0sBqaf2NJCk5q9UnZqu2Xuz018Ur";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customers',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

//main page
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget current = ToDoCustomers();
  bool connected = false;

  @override
  void initState() {
    super.initState();

    // Establish connection to Parse
    connectParse()
        // run code after connection
        .then(onConnection)
        // TODO: notify the user of the error
        .catchError((error) => print('Could not connect to Parse.\n' + error));
  }

  // Establishes a DEBUG connection with Parse server
  Future connectParse() {
    return Parse().initialize(
      applicationId,
      parseServerUrl,
      clientKey: clientKey,
      masterKey: masterKey,
      debug: true,
    );
  }

  void onConnection(value) {
    setState(() {
      connected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: Drawer(
            child: Container(
              color: Colors.black,
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        current = SearchCustmer();
                      });

                      Navigator.pop(context);
                    },
                    focusColor: Colors.amber,
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        current = ToDoCustomers();
                      });

                      Navigator.pop(context);
                    },
                    focusColor: Colors.amber,
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    leading: Icon(Icons.home, color: Colors.white),
                    title: Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    focusColor: Colors.amber,
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    leading: Icon(Icons.subdirectory_arrow_right,
                        color: Colors.white),
                    title: Text(
                      'Sign up a user',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    focusColor: Colors.amber,
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    leading: Icon(Icons.do_not_disturb_on, color: Colors.red),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            flexibleSpace: Row(
              children: [Icon(Icons.access_alarm)],
            ),
            bottomOpacity: 0.9,
            elevation: 14,
            title: Text("Hamdan's"),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          // TODO: replace the loading text with visualization
          body: connected ? current : Text('Loading'),
        ),
      ),
    );
  }
}
