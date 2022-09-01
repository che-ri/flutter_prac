// import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print('createState');
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  var switchValue = false;
  String test = "hello";
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    print('build');

    if (mounted == true) {
      print('mounted==true');
    }

    if (mounted == false) {
      print('mounted==false');
    }

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        darkTheme: ThemeData.light(),
        home: Scaffold(
          body: Center(
              child: ElevatedButton(
            child: Text('$test'),
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(_color)),
            onPressed: () {
              if (_color == Colors.blue) {
                setState(() {
                  print('setState');
                  test = 'flutter';
                  _color = Colors.amber;
                });
              } else {
                setState(() {
                  print('setState');
                  test = 'hello';
                  _color = Colors.blue;
                });
              }
            },
          )),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant MyApp oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    // TODO: implement deactivate
    super.deactivate();
    print('dispose');
  }
}

/**
 * 첫 렌더링시 콘솔
 * I/flutter (11651): createState
 * I/flutter (11651): initState
 * I/flutter (11651): didChangeDependencies
 * I/flutter (11651): build
 * I/flutter (11651): mounted==true
 */

/**
 * 업데이트시 콘솔
 * I/flutter (11651): setState
 * I/flutter (11651): build
 * I/flutter (11651): mounted==true
 */