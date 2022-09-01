// import 'dart:html';

import 'package:app/imageWidget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: _title, home: WidgetApp());
  }
}

class WidgetApp extends StatefulWidget {
  @override
  _WidgetApp createState() => _WidgetApp();
}

class _WidgetApp extends State<WidgetApp> {
  String sum = "";
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Center(
              child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(15),
              child: Text('Flutter',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontFamily: 'Pacifico'))),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: value1,
              )),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: value2,
              )),
          Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                  onPressed: () => {
                        setState(() {
                          int result = int.parse(value1.value.text) +
                              int.parse(value2.value.text);
                          sum = '$result';
                        })
                      },
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text(
                        '더하기',
                      )
                    ],
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.amber)))),
          Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                '결과 : $sum',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              )),
        ],
      ))),
    );
  }
}
