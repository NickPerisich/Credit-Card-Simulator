import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.reference();
final userReference = databaseReference.child('0');

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: FrontPage(),
    );
  }
}

class FrontPage extends StatefulWidget {
  @override
  FrontPageState createState() => new FrontPageState();
}

class FrontPageState extends State<FrontPage> {
  int cash;
  StreamSubscription<Event> _onCashChangedSubscription;
  @override void initState() {
    super.initState();
    _onCashChangedSubscription = userReference.child('cash').onValue.listen((Event event) {
      setState(() {
        print("TEST");
        cash = event.snapshot.value as int;
      });
    });
  }

  Widget hamburger() {
    return new Drawer(
        child: new ListView(
      children: <Widget>[
        new DrawerHeader(
          child: new Text('Header'),
        ),
        new ListTile(
          title: new Text('Log Out'),
          onTap: () {},
        ),
        new ListTile(
          title: new Text('Parental Settings'),
          onTap: () {},
        ),
        new ListTile(
          title: new Text('Educate Me'),
          onTap: () {},
        ),
      ],
    ));
  }

  //The logo seen
  Widget logo() {
    return Column(children: []);
  }

  //The whole level status area, including the pokemon-go style bar and emoji and balance due date
  Widget levelStatus() {
    return Column(children: []);
  }

  //The user information, including available cash, payment due, and paycheck due
  Widget userCashInfo() {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          child: Text(
            "Available Cash: \$$cash",
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          child: Text(
            "Payment Due: ",
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          child: Text(
            "Paycheck: ",
          ),
        ),
      ),
    ]);
  }

  //The payment button
  Widget payButton() {
    return new RaisedButton (
      child: Text('Pay'),
      onPressed: () {
        // Navigate to second screen when tapped!
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PayScreen()),
        );
      },
    );
  }

  Widget creditBar() {
    return Container(
      child: LinearProgressIndicator(
        value: 0.3,
        backgroundColor: Colors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KapitalKidz'),
      ),
      drawer: hamburger(),
      body: widgetList(),
    );
  }

  Widget widgetList() {
    return new Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          logo(),
          levelStatus(),
          creditBar(),
          userCashInfo(),
          payButton()
        ]));
  }
}

class PayScreen extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Pay Screen"),
      ),
      body: new Text("Another Page...!!!!!!"),
    );
  }
}