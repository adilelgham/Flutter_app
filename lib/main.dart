import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'settings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class Product {
  final int index;
  final String name;

  final String merk;
  final String prijs;

  Product(this.index, this.name, this.merk, this.prijs);
}

var itemID;

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
    String dir = path.dirname(picture.path);
    String newPath = path.join(dir, 'case01wd03id01.jpg');

    this.setState(() {
      _imageFile = picture;
    });
    if (_imageFile == null) {
      Navigator.pop(context);
    } else {
      String base64Image = base64Encode(picture.readAsBytesSync());
      String fileName = newPath.split("/").last;
      var body = jsonEncode({"file": base64Image, "name": fileName});

      await http
          .post("http://10.0.2.2/sendPicture",
              headers: {"Content-Type": "application/json"}, body: body)
          .then((res) {
        print(res.statusCode);
      }).catchError((err) {
        print(err);
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => listProducts()));
    }
  }

  _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    String dir = path.dirname(picture.path);
    String newPath = path.join(dir, 'case01wd03id01.jpg');

    this.setState(() {
      _imageFile = picture;
    });

    if (imageFile == null) {
      Navigator.pop(context);
    } else {
      String base64Image = base64Encode(picture.readAsBytesSync());
      String fileName = newPath.split("/").last;
      var body = jsonEncode({"file": base64Image, "name": fileName});

      await http
          .post("http://10.0.2.2/sendPicture",
              headers: {"Content-Type": "application/json"}, body: body)
          .then((res) {
        print(res.statusCode);
      }).catchError((err) {
        print(err);
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => listProducts()));
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
                  radius: 90,
                  backgroundImage: AssetImage('images/fotoHome.jpg'),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings()));
                        },
                      ),
                    )),
              ]),
        ));
  }
}

class listProducts extends StatefulWidget {
  listOfProducts createState() => listOfProducts();
}

class listOfProducts extends State<listProducts> {
  Future<List<Product>> fetchProductList() async {
    var response = await http.get('http://10.0.2.2/products');
    var prediction = null;
    await http.get("http://10.0.2.2/prediction").then((res) {
      print(res.statusCode);
      prediction = json.decode(res.body);
    }).catchError((err) {
      print(err);
    });
    var jsonData = json.decode(response.body);

    List<Product> products = [];

    for (var p in jsonData) {
      Product product = Product(p["index"], p["name"], p["merk"], p["prijs"]);
      if (p['name'] == prediction) {
        products.add(product);
      }
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Carrefour'),
        ),
        body: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Image.file(MainPage().imageFile(), width: 350, height: 250),
                Text(
                  'Kies uit tussen de gegeven product(en):',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Divider(color: Colors.black),
                FutureBuilder(
                    future: fetchProductList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                            child: Text("Loading..."),
                          ),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              var item ="";
                              if(snapshot.data[index].name != null) {
                                item = snapshot.data[index].name;
                              }
                              if (item != "") {
                                return RaisedButton(
                                    child: Text(item),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                  snapshot.data[index])));
                                    });
                              } else if (item == "") {
                                return Container(
                                  child: Center(
                                    child: Text("No product found"),
                                  ),
                                );
                              }
                            });
                      }
                    })
              ],
            )));
  }
}

class DetailPage extends StatelessWidget {
  final Product product;

  DetailPage(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          new SizedBox(
              height: 100.0,
              width: 100.0,
              child: new IconButton(
                icon: Image.asset('images/c4.png'),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp())),
              ))
        ]),
      ),
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(MainPage().imageFile(), width: 300, height: 300),
            Divider(
              color: Colors.teal.shade700,
            ),
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                    leading: Icon(
                      Icons.title,
                      color: Colors.lightBlue,
                    ),
                    title: Text(product.name,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.lightBlue,
                        )))),
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                    leading: Icon(
                      Icons.euro,
                      color: Colors.pink,
                    ),
                    title: Text(product.prijs,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.pink,
                        )))),
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                    leading: Icon(
                      Icons.bookmark,
                      color: Colors.purple,
                    ),
                    title: Text(product.merk,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.purple,
                        ))))
          ],
        ),
      ),
    );
  }
}
