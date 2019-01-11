import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'PayScreen.dart';
import 'ParentSettingScreen.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Pres.dart';

final databaseReference = FirebaseDatabase.instance.reference();
final userReference = databaseReference.child('0');

int cash;
int penalty;
int paymentDue = 0;
int balance = 0;
int currentExp;
int level;
int maxExp;
int minPayment;
String name;
int parentalPasscode;
int allowanceAmount;
int limit = 1;

void main() => runApp(MyApp());
final GlobalKey<AnimatedCircularChartState> _chartKey =
    new GlobalKey<AnimatedCircularChartState>();

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
  @override
  void initState() {
    super.initState();
    userReference.child('penalty').onValue.listen((Event event) {
      setState(() {
        penalty = event.snapshot.value as int;
      });
    });
    userReference.child('parental_passcode').onValue.listen((Event event) {
      setState(() {
        parentalPasscode = event.snapshot.value as int;
      });
    });
    userReference.child('name').onValue.listen((Event event) {
      setState(() {
        name = event.snapshot.value.toString();
      });
    });
    userReference.child('cash').onValue.listen((Event event) {
      setState(() {
        cash = event.snapshot.value as int;
      });
    });
    userReference.child('payment_due').onValue.listen((Event event) {
      setState(() {
        paymentDue = event.snapshot.value as int;
        paymentDue = paymentDue * 1000;
      });
    });
    userReference.child('balance').onValue.listen((Event event) {
      setState(() {
        balance = event.snapshot.value as int;
      });
    });
    userReference.child('current_exp').onValue.listen((Event event) {
      setState(() {
        currentExp = event.snapshot.value as int;
        _chartKey.currentState.updateData(createChartData());
      });
    });
    userReference.child('level').onValue.listen((Event event) {
      setState(() {
        level = event.snapshot.value as int;
      });
    });
    userReference.child('max_exp').onValue.listen((Event event) {
      setState(() {
        maxExp = event.snapshot.value as int;
        _chartKey.currentState.updateData(createChartData());
      });
    });
    userReference.child('minimum_payment').onValue.listen((Event event) {
      setState(() {
        minPayment = event.snapshot.value as int;
      });
    });
    userReference.child('limit').onValue.listen((Event event) {
      setState(() {
        limit = event.snapshot.value as int;
      });
    });
  }

  Future<void> levelUpDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You just leveled up!'),
          content: Image.asset('em7.png'),
          actions: <Widget>[
            FlatButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

Widget hamburger() {
    return new Drawer(
        child: new ListView(
      children: <Widget>[
        new DrawerHeader(
          child: Image(
            image: AssetImage("images/kkidz.png"),
            fit: BoxFit.cover,
          ),
        ),
        new ListTile(
          title: new Text('Parental Settings'),
          onTap: () {
            // Navigate to second screen when tapped!
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ParentSettingsScreen()),
            );
          },
        ),
        new ListTile(
          title: new Text('Pay your Bill'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PayScreen()),
            );
          },
        ),
        new ListTile(
          title: new Text('pres'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Presentation()),
            );
          },
        ),
      ],
    ));
  }

  //The logo seen
  Widget logo() {
    return Container(
      child: Image.asset('images/kkidz.png'),
      // ...
    );
  }

  List<CircularStackEntry> createChartData() {
    return [new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(
          (currentExp / maxExp * 50),
          Colors.lightGreen[400],
          rankKey: 'completed',
        ),
        new CircularSegmentEntry(
          50 - (currentExp / maxExp * 50),
          Colors.grey[200],
          rankKey: 'remaining',
        ),
      ],
      rankKey: 'progress',
    )];
  }

  Widget createCircularChart() {
    return RotatedBox(
      quarterTurns: -1,
      child: new AnimatedCircularChart(
        key: _chartKey,
        size: Size(400, 400),
        initialChartData: createChartData(),
        chartType: CircularChartType.Radial,
        percentageValues: true,
        edgeStyle: SegmentEdgeStyle.round
    ));
  }

  Widget createEmoji(int _level) {
    return new Container(
      width: 100.0,
      height: 100.0,
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/em5.png'), fit: BoxFit.fill),
      ),
    );
  }

  //The whole level status area, including the pokemon-go style bar and emoji and balance due date
  Widget levelStatus() {
    return new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        createCircularChart(),
        Positioned(
          child: createEmoji(level),
          top: 110
        )
      ],
    );
  }

  //The user information, including available cash, payment due, and paycheck due

  Widget userCashInfo() {
    double fontSize = 18;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(paymentDue);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                "Amount Spent: \$$balance",
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                "Available Cash: \$$cash",
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                "Payment Due: " +
                    date.month.toString() +
                    "/" +
                    date.day.toString() +
                    "/" +
                    date.year.toString(),
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  //The payment button
  Widget payButton() {
    return new Padding(
      padding: EdgeInsets.all(16),
      child: RaisedButton (
        child: Text('Pay', style: TextStyle(fontSize: 20),),
        onPressed: () {
          // Navigate to second screen when tapped!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PayScreen()),
          );
        },
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      ),
    );
  }

  Widget creditBar() {
    return Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [new Text("\$0"), new Text("\$" + limit.toString())]),
      SizedBox(
        height: 20,
        child: LinearProgressIndicator(
          value: balance / limit,
          backgroundColor: Colors.green,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ),
    ]);
  }

  Widget amountSpent() {
    return new Card(
      child: Column(
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.payment),
              // ignore: const_eval_throws_exception
              title: Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                child: Text(
                  "Amount spent: \$$balance",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget availableCash() {
    return new Card(
      child: Column(
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.attach_money),
              // ignore: const_eval_throws_exception
              title: Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                child: Text(
                  "Available cash: \$$cash",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget paymentDueDate() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(paymentDue);
    return new Card(
      child: Column(
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.calendar_today),
              // ignore: const_eval_throws_exception
              title: Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                child: Text(
                  "Payment Due: " +
                      date.month.toString() +
                      "/" +
                      date.day.toString() +
                      "/" +
                      date.year.toString(),
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              )
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capital One Allowance'),
      ),
      drawer: hamburger(),
      body: widgetList(),
    );
  }

  Widget widgetList() {
    return new Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ListView(children: [
          logo(),
          levelStatus(),
          creditBar(),
          amountSpent(),
          availableCash(),
          paymentDueDate(),
          payButton(),
        ]));
  }
}
