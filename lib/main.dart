import 'package:flutter/material.dart';

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

  Widget hamburger() {
    return new Drawer(
        child: new ListView(
          children: <Widget> [
            new DrawerHeader(child: new Text('Header'),),
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
        )
    );
  }

  //The logo seen
  Widget logo() {
    return Column(children: [

    ]);

  }

  //The whole level status area, including the pokemon-go style bar and emoji and balance due date
  Widget levelStatus() {
    return Column(children: [

    ]);

  }

  //The user information, including available cash, payment due, and paycheck due
  Widget userCashInfo() {
    return Column(children: [

    ]);
  }


  //The payment button
  Widget payButton() {
    return Column(children: [

    ]);
  }

  Widget creditBar() {
     return new Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: LinearProgressIndicator(
            value: 0.3,
            backgroundColor: Colors.red,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
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
    return ListView (
      children: [logo(), levelStatus(), creditBar(), userCashInfo(), payButton()]
    );
  }

}
