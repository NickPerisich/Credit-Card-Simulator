import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'PayScreen.dart';
import 'ParentSettingScreen.dart';

void main() => runApp(MyApp());
final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

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
          onTap: () {
            // Navigate to second screen when tapped!
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ParentSettingsScreen()),
            );
          },
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
    return Container(
        child: Image.asset('images/kkidz.png'),
    // ...
    );
  }


  Widget createCircularChart()
  {
    return new AnimatedCircularChart(
      key: _chartKey,
      size: Size(200, 200),
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              33.33,
              Colors.lightGreen[400],
              rankKey: 'completed',
            ),
            new CircularSegmentEntry(
              66.67,
              Colors.grey[600],
              rankKey: 'remaining',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      percentageValues: true,
      holeLabel: 'Level 5',
      labelStyle: new TextStyle(
      color: Colors.blueGrey[600],
      fontWeight: FontWeight.bold,
        fontSize: 30.0,
      )
    );
  }

  Widget createEmoji(int _level)
  {
    return new Container(
      width: 100.0,
      height: 100.0,
      alignment: Alignment.center,
      decoration: new BoxDecoration(

        image: DecorationImage(
            image: AssetImage('images/em5.png'),
            fit: BoxFit.fill
        ),
      ),
    );
  }

  //The whole level status area, including the pokemon-go style bar and emoji and balance due date
  Widget levelStatus() {
    return Row(children: [
      createCircularChart(),
      createEmoji(5)
    ]);
  }

  //The user information, including available cash, payment due, and paycheck due

  Widget userCashInfo() {
    double fontSize = 18;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                "Available Cash: ",
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
                "Payment Due: ",
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
                "Paycheck: ",
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
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          logo(),
          levelStatus(),
          creditBar(),
          userCashInfo(),
          payButton()
        ]));
  }

}
