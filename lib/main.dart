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
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget {
  const HttpApp({super.key});

  @override
  State<HttpApp> createState() => _HttpAppState();
}

class _HttpAppState extends State<HttpApp> {
  String result = '';
  List? data;

  Future<String> getData() async {
    var url = 'http://dapi.kakao.com/v3/search/book?target=title&query=doit';
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": dotenv.env['KAKAO_API_KEY']!});

    setState(() {
      var dataConvertedToJson = json.decode(response.body);
      data!.addAll(dataConvertedToJson['documents']);
    });
    return response.body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = new List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('http example')),
      body: Container(
        child: Center(
            child: data!.length == 0
                ? Text(
                    '데이터가 없습니다.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
                : ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Image.network(
                                  data![index]['thumbnail'],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.contain,
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      //MediaQuery.of(context).size : 스마트폰의 화면 크기
                                      width: MediaQuery.of(context).size.width -
                                          150,
                                      child: Text(
                                        data![index]['title'].toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(data![index]['authors'].toString()),
                                    Text(data![index]['sale_price'].toString()),
                                    Text(data![index]['status'].toString()),
                                  ],
                                )
                              ]),
                        ),
                      );
                    },
                  )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {getData()},
        child: Icon(Icons.file_download),
      ),
    );
  }
}
