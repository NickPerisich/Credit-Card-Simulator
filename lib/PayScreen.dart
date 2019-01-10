import 'package:flutter/material.dart';

/*
    This file renders the payment screen triggered by clicking on the
    "Pay" button on the main screen
 */

class PayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Screen'),
      ),
      body: widgetList(),
    );
  }
}

Widget amountOwedCard() {
  return new Card(
    child: Column(
        children: <Widget>[
          const ListTile(
          leading: Icon(Icons.payment),
          title: Text('You owe'),
          //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        ),
        ],
    ),
  );
}

Widget widgetList() {
  return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(children: [
        amountOwedCard()
      ]));
}

