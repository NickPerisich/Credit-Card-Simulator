import 'package:flutter/material.dart';

/*
    This file renders the ParentSettings screen triggered by clicking on the
    "Parent Settings" field on the hamburger
 */

class ParentSettingsScreen extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Parent Settings Screen"),
      ),
      body: new Text("This will display the parent settings"),
    );
  }
}
