import 'package:flutter/material.dart';
import 'main.dart';

/*
    This file renders the payment screen triggered by clicking on the
    "Pay" button on the main screen
 */

class PaymentScreenRender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Screen',
      home: PayScreen(),
    );
  }
}

class PayScreen extends StatefulWidget {
  @override
  PayScreenState createState() => new PayScreenState();

}

class PayScreenState extends State<PayScreen> {
  int cashAmount = cash;
  int balanceAmount = balance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Screen'),
      ),
      body: widgetList(),
    );
  }
  Widget amountOwedCard(cashBalance, creditAmount) {
    //int balance = 100;
    //int amountOwed = 5;
    return new Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.payment),
            // ignore: const_eval_throws_exception
            title: Text("You have $cash\nYou owe a balance of $creditAmount\n", style: TextStyle(fontSize: 32),),
          ),
        ],
      ),
    );
  }

  Widget payButton() {
    return new RaisedButton (
      child: Text('Pay'),
      onPressed: () {
        handleButtonPress();
        //userReference.child("balance").set(balance);
        // userReference.child("cash").set((cash-balance));
      },
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
    );
  }

  void handleButtonPress() {
    setState(() {
      if (balance > cash){
       // print(cash);
        //balance = balance - cash;
        int temp = balance - cash;
        print(temp);
        userReference.child('balance').set(temp);
        cash = 0;
        userReference.child('cash').set(cash);
      } else if (balance < cash){

        cash = cash - balance;
        userReference.child('cash').set(cash);
        balance = 0;
        userReference.child('balance').set(balance);
      } else if ( balance == cash) {
        cash = 0;
        userReference.child('cash').set(cash);
        balance = 0;
        userReference.child('balance').set(balance);
      }
    });
    print("balance is $balance");
    print("cash is $cash");
  }


/*
  void setCashState() {
    setState(() {
      if (balance - cash > 0){
        balance = 0;
      } else {
        balance = balance - cash;
      }
    });
  }
*/
  Widget widgetList() {
    return new Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          amountOwedCard(cash, balance),
          payButton()
        ]));
  }

}


