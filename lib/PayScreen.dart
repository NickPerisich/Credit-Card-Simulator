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
  int balance = 100;
  int amountOwed = 5;
  return new Card(
    child: Column(
        children: <Widget>[
          ListTile(
          leading: Icon(Icons.payment),
          // ignore: const_eval_throws_exception
          title: Text("You owe $amountOwed dollars and your balance is $balance", style: TextStyle(fontSize: 24),),
          //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        ),
          FlatButton(onPressed: () => balance - amountOwed, child: const Text("Pay your balance"))

        ],

    ),
  );

}

//int balance = 1300;

Widget widgetList() {
  return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(children: [
        amountOwedCard()
      ]));
}

