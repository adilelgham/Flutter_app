import 'package:flutter/material.dart';

import 'product.dart';
import 'main.dart';


List<String> text = ['product1', 'product2','product3'];

class listOfProducts extends StatelessWidget {
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
        children: [
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