import 'package:flutter/material.dart';
import 'main.dart';

class Presentation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presentation',
      home: PresentationScreen(),
    );
  }
}

class PresentationScreen extends StatefulWidget {
  @override
  PresentationScreenState createState() => new PresentationScreenState();
}

class PresentationScreenState extends State<PresentationScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text('Bad'),
          onPressed: () {
            userReference.child('balance').set(47);
            userReference.child('cash').set(12);
            userReference.child('level').set(50);
            userReference.child('max_exp').set(20);
          },
        ),
        RaisedButton(
          child: Text('Good'),
          onPressed: () {
            userReference.child('balance').set(12);
            userReference.child('cash').set(47);
            userReference.child('level').set(50);
            userReference.child('max_exp').set(80);
          },
        ),
        RaisedButton(
          child: Text('Increase Cash'),
          onPressed: () {
            userReference.child('cash').set(cash + 50);
          },
        ),
        RaisedButton(
          child: Text('Increase Balance'),
          onPressed: () {
            userReference.child('balance').set(balance + 50);
          },
        ),
        RaisedButton(
          child: Text('Decrease Cash'),
          onPressed: () {
            userReference.child('cash').set(cash - 50);
          },
        ),
        RaisedButton(
          child: Text('Decrease Balance'),
          onPressed: () {
            userReference.child('balance').set(balance - 50);
          },
        ),
      ],
    );
  }
}
