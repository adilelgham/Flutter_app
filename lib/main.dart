import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'settings.dart';
import 'listOfProducts.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Home extends StatefulWidget{
  MainPage createState()=> MainPage();
}
// ignore: must_be_immutable
class MainPage extends State<Home> {
  File imageFile;
  _openGallary(BuildContext context) async{
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState( (){
      imageFile = picture;
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>listOfProducts()));
  }

  _openCamera(BuildContext context) async{
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState( (){
      imageFile = picture;
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>listOfProducts()));
  }

  _decideImageView(){
    if(imageFile == null){
        return Text('No Image Selected');
    } else{
      Image.file(imageFile, width: 300, height: 300);
    }
  }
Future<void> _showChoiceDialog(BuildContext context){
  return showDialog(context: context,builder: (BuildContext context){
    return AlertDialog(
      title: Text("Maak een keuze"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
          GestureDetector(
            child: Text("Galerij"),
            onTap: (){
              _openGallary(context);
            },
          ),
            Padding(padding: EdgeInsets.all(6.0)),
            GestureDetector(
              child: Text("Camera"),
              onTap: (){
                _openCamera(context);
              },
            )
          ]
        )
      )
    );
  });
}

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
                radius: 60,
                backgroundImage: AssetImage('images/CameraCarrefour.jpg'),
              ),

                  RaisedButton(
                    child: Icon(
                      Icons.settings,
                      color: Colors.teal,
                    ),
                    onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>Settings())
                      );
                    },
                  ),
                  RaisedButton(onPressed: () {
                    _showChoiceDialog(context);
                  },child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.teal,
                  ),

                  ),

            ])));
  }
}

class Settingsroute extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Taal';
                  }
                  return null;
                },
              ),
    ElevatedButton(
    onPressed: () {
    // Validate returns true if the form is valid, otherwise false.
    if (_formKey.currentState.validate()) {
    // If the form is valid, display a snackbar. In the real world,
    // you'd often call a server or save the information in a database.

    ScaffoldMessenger
        .of(context)
        .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
    },
    child: Text('Submit'),
    ),

    ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: Text('Go back!'),
              ),
            ]));
  }
}


