import 'dart:io';
import 'package:flutter/material.dart';
import 'main.dart';

class Settings extends StatefulWidget {
  SettingPage createState() => SettingPage();
}

class SettingPage extends State<Settings> {
  int colorGroupValue;
  int group;
  static int _appBarColor;
  _checkColor(){
  if(_appBarColor == null){
  _appBarColor = 0xff26c6da;
  }
  }
  int appBarColor() => _appBarColor;

  @override
  Widget build(BuildContext context) {
    _checkColor();
    return Scaffold(
        appBar: new AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: new IconButton(
                      icon: Image.asset('images/c4.png'),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp())),
                    ))
              ]),
        ),
        backgroundColor: Color(SettingPage().appBarColor()),
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
              Text('Kleur'),
              Row(children: <Widget>[
                Radio(
                    value: 0xff26c6da,
                    groupValue: colorGroupValue,
                    onChanged: (val) {
                      colorGroupValue = val;
                      setState(() {});
                    }),
                Text('Blauw')
              ]),
              Row(children: <Widget>[
                Radio(
                    value: 0xffe53935,
                    groupValue: colorGroupValue,
                    onChanged: (val) {
                      colorGroupValue = val;
                      setState(() {});
                    }),
                Text('Rood')
              ]),
              Row(children: <Widget>[
                Radio(
                    value: 0xff69f0ae,
                    groupValue: colorGroupValue,
                    onChanged: (val) {
                      colorGroupValue = val;
                      setState(() {});
                    }),
                Text('Groen')
              ]),
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
              RaisedButton(
                child: Icon(
                  Icons.send,
                  color: Colors.teal,
                ),
                onPressed: () {
                  _appBarColor = colorGroupValue;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));

                },
              ),
            ])));
  }
}
