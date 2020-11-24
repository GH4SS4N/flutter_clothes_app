import 'package:flutter/material.dart';

import 'Model/ParseConnection.dart';
import 'View/Pages/SearchCustomer.dart';
import 'View/Pages/OrdersHome.dart';

void main() {
  //TODO: @GH4SS4N make the login page and the checker
  runApp(MyApp());
}

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
  Widget current = OrdersHome();
  bool connected = false;

  @override
  void initState() {
    super.initState();

    // Establish connection to Parse
    connectParse()
        // run code after connection
        .then(onConnection)
        // TODO: notify the user of the error(Ghassan)
        .catchError((error) =>
            print('Could not connect to Parse.\n' + error.toString()));
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
                          current = SearchCustomer();
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
                          current = OrdersHome();
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
                      onTap: () {},
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
            body: connected
                ? current
                : Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
