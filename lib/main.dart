import 'package:app/largeFileMain.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: 'config/.env');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Page')),
      body: Container(
          child: Center(
        child: Text('메인 페이지'),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator은 스택(stack)을 이용해 페이지를 관리할 때 사용하는 클래스이다.
          //Navigator의 of(context)함수는 현재 페이지를 나타내고,
          //push()함수는 스택에 페이지를 쌓는 역할을 한다.
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return SecondPage();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('두번째 페이지')),
      body: Container(
          child: Center(
        child: ElevatedButton(
            onPressed: () {
              //pop()함수는 스택 메모리에서 맨 위에 있는 페이지를 제거한다.
              Navigator.of(context).pop(); //지금 페이지를 종료
            },
            child: Text('돌아가기')),
      )),
    );
  }
}
