import 'dart:io';
import 'package:flutter/material.dart';
import 'main.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Carrefour'),
                Container(
                  //  margin: const EdgeInsets.only(right: 75),
                  child: Image.asset(
                    '/images/c4.png',
                  ),
                ),
              ]),
        ),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('images/settings.png'),
                ),
              ),
              Text('Taal'),

              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Taal';
                  }
                  return null;
                },
              ),
              RaisedButton(
                child: Icon(
                  Icons.west,
                  color: Colors.teal,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
            ])));
  }
}
