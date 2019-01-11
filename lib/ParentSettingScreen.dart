import 'package:flutter/material.dart';
import 'main.dart';

/*
    This file renders the ParentSettings screen triggered by clicking on the
    "Parent Settings" field on the hamburger
 */

class ParentSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Parent Settings Screen"),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class. This class will hold the data related to
// our Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final limitAdjust = TextEditingController();
  final allowanceAdjust = TextEditingController();
  final penaltyAdjust = TextEditingController();
  final pinAdjust = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    limitAdjust.dispose();
    allowanceAdjust.dispose();
    penaltyAdjust.dispose();
    pinAdjust.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(children: [
          TextField(
            controller: limitAdjust,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(labelText: "Credit Limit"),
          ),
          TextField(
            controller: allowanceAdjust,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(labelText: "Allowance"),
          ),
          TextField(
            controller: penaltyAdjust,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(labelText: "Interest/Penalty Rate"),
          ),
          TextField(
            controller: pinAdjust,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(labelText: "Parent PIN"),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog with the
        // text the user has typed into our text field.
        onPressed: () {
          if (int.parse(pinAdjust.text) == parentalPasscode) {
            userReference.child('limit').set(int.parse(limitAdjust.text));
            userReference.child('allowance_amount').set(int.parse(allowanceAdjust.text));
            userReference.child('penalty').set(int.parse(penaltyAdjust.text));
          }
        },
        child: Icon(Icons.check),
        elevation: 100,
      ),
    );
  }
}
