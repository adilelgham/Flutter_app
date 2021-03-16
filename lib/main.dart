import 'package:flutter/material.dart';

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

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  void _showDialog(BuildContext context, {String title, String msg}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        RaisedButton(
          color: Colors.teal,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (x) => dialog);
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
              ButtonBar(children: <Widget>[
                FlatButton(
                    child: Icon(
                      Icons.settings,
                      color: Colors.teal,
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Settingsroute()),
                      );
                    }),
              ])
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
