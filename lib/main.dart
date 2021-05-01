import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'settings.dart';
import 'listOfProducts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('fr', ''),
        const Locale('nl', ''),
      ],
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  MainPage createState() => MainPage();
}

// ignore: must_be_immutable
class MainPage extends State<Home> {
  static File _imageFile;
  File imageFile() => _imageFile;
  _openGallary(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _imageFile = picture;
    });
    if (_imageFile == null) {
      Navigator.pop(context);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => listOfProducts()));
    }
  }

  _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      _imageFile = picture;
    });
    if (imageFile == null) {
      Navigator.pop(context);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => listOfProducts()));
    }
  }

  _decideImageView() {
    if (_imageFile == null) {
      return Text('No Image Selected');
    } else {
      Image.file(_imageFile, width: 300, height: 300);
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Maak een keuze"),
              content: SingleChildScrollView(
                  child: ListBody(children: <Widget>[
                GestureDetector(
                  child: Text("Galerij"),
                  onTap: () {
                    _openGallary(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(6.0)),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ])));
        });
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.lightBlueAccent,
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text(
                'Welkom!',
                style: TextStyle(
                  fontSize: 60.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                'Om uw product te scannen gelieve op de cameraknop te drukken.',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircleAvatar(
                radius:90,
                backgroundImage: AssetImage('images/CameraCarrefour.jpg'),
              ),
              ButtonTheme(
                minWidth: 100,
                height: 100,
                buttonColor: Colors.green,
                child: RaisedButton(
                  onPressed: () {
                    _showChoiceDialog(context);
                  },
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.teal,
                    size: 70,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
              child: ButtonTheme(
                minWidth: 50,
                height: 50,
                buttonColor: Colors.grey,
                child: RaisedButton(
                  child: Icon(
                    Icons.settings,
                    color: Colors.teal,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                ),
              )),
            ]),
        ));
  }
}
