import 'package:flutter/material.dart';

import 'product.dart';
import 'main.dart';
import 'settings.dart';


List<String> text = ['product1', 'product2','product3'];

class listOfProducts extends StatelessWidget {
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
        backgroundColor: Color(SettingPage().appBarColor()),
        body: SafeArea(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(MainPage().imageFile(), width: 350, height: 250),
          Text(
            'Kies uit tussen de gegeven product(en):',
            style: TextStyle(
              fontSize: 40.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Divider(
              color: Colors.black
          ),
        for ( var i in text )
          RaisedButton(
            child:   Text(i.toString()),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Product()));
            },
          ),
        ],
        )
        )
    );
  }

}