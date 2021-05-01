import 'package:flutter/material.dart';
import 'package:ai_application/main.dart';
import 'settings.dart';

class Product extends StatelessWidget {
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
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('images/tuc.png'),
            ),
            Text(
              'Tuc sweet red paprika',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: Colors.teal.shade700,
            ),
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                    leading: Icon(
                      Icons.euro,
                      color: Colors.pink,
                    ),
                    title: Text(
                        '1.90',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.pink,
                        )
                    )
                )
            ),
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                    leading: Icon(
                      Icons.bookmark,
                      color: Colors.purple,
                    ),
                    title: Text(
                        'Tuc',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.purple,
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