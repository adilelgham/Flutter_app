import 'package:flutter/material.dart';

class Product extends StatelessWidget {
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
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('images/tuc.png'),
            ),
            Text(
              'Tuc sweet red paprika',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.teal.shade700,
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10.0),
              child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.euro,
                      color: Colors.teal,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '1.47',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 20.0,
                      ),
                    )
                  ]
              ),
            ),
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                    leading: Icon(
                      Icons.bookmark,
                      color: Colors.teal,
                    ),
                    title: Text(
                        'Tuc',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.teal,
                        )
                    )
                )
            )
          ],
        ),
      ),
    );
  }
}