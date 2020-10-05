import 'dart:io';
//import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'Pages/SearchCustomer.dart';
import 'Pages/ToDoCustomers.dart';

// import 'DoneCustomers.dart';
// import 'ToDoCustomers.dart';

void main() {
  runApp(MyApp());
}

const applicationId = "GHOhkmIucHJIhnhqSHVPMgJXpJmKDBCxt2Nn4Bvp";
const parseServerUrl = "https://parseapi.back4app.com/";
const clientKey = "9FRMiSnXcxB2MzJSuRt7jS3v75vrOImvh8WnkZIF";
const masterKey = "7hvm5PaDdxdD0sBqaf2NJCk5q9UnZqu2Xuz018Ur";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custmers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

//main page
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// clientKey: "9FRMiSnXcxB2MzJSuRt7jS3v75vrOImvh8WnkZIF"
class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> studentNames = ["Not yet baby", "Wallah not yet"];
  var dietPlan;

  @override
  void initState() {
    super.initState();
    Parse()
        .initialize(
          applicationId,
          parseServerUrl,
          clientKey: clientKey,
          masterKey: masterKey,
          debug: true,
        )
        .then(onConnection)
        .catchError((error) => print("error"));
  }

  void onConnection(value) {
    getStudentNames();
  }

  void writeStudentNames() async {
    dietPlan = ParseObject('DietPlan')
      ..set('Name', 'Ketogenic')
      ..set('Fat1', 65);
    await dietPlan.save();
  }

  void getStudentNames() async {
    var students = await ParseObject("DietPlan").getAll();
    var newStudentNames = [];

    setState(() {
      if (students.success) {
        for (var student in students.results) {
          print(student['Name']);
          newStudentNames.add(student["Name"]);
        }

        studentNames = newStudentNames;
      } else {
        print("Failed ya 3ammy");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Row(
                children: [Icon(Icons.access_alarm)],
              ),
              bottomOpacity: 0.9,
              elevation: 14,
              title: Text("Hamdan's"),
              centerTitle: true,
              backgroundColor: Colors.black,
              bottom: TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.access_alarm),
                  //text: 'to do',
                ),
                Tab(
                  icon: Icon(Icons.search),
                )
              ]),
            ),
            body: TabBarView(children: [
              ToDoCustomers(),
              SearchCustmer(),
            ])
            // This trailing comma makes auto-formatting nicer for build methods.
            ),
      ),
    );
  }
}