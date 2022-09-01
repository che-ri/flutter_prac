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
  String? _buttonText;
  List _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  List<DropdownMenuItem<String>> _dropDownMenuItems =
      new List.empty(growable: true);
  @override
  void initState() {
    super.initState();
    for (var item in _buttonList) {
      _dropDownMenuItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    _buttonText = _dropDownMenuItems[0].value;
  }

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
              child: DropdownButton(
                  items: _dropDownMenuItems,
                  onChanged: (String? value) {
                    setState(() {
                      _buttonText = value;
                    });
                  },
                  value: _buttonText)),
          Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                  onPressed: () => {
                        setState(() {
                          var value1Int = num.parse(value1.value.text);
                          var value2Int = num.parse(value2.value.text);
                          var result;
                          switch (_buttonText) {
                            case "더하기":
                              result = value1Int + value2Int;
                              break;
                            case "빼기":
                              result = value1Int - value2Int;
                              break;
                            case "곱하기":
                              result = value1Int * value2Int;
                              break;
                            case "나누기":
                              result = value1Int / value2Int;
                              break;
                            default:
                              result = 0;
                              break;
                          }
                          sum = '$result';
                        })
                      },
                  child: Row(
                    children: [Icon(Icons.add), Text(_buttonText!)],
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
