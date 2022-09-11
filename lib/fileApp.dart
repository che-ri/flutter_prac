import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/**
 * 내부 저장소의 디렉터리 데이터 가져오는 함수
 * getApplicationDocumnetsDirectory() : 디렉터리 경로의 데이터를 가져오는 함수
 * getTemporaryDirectory() : 임시 디렉터리 경로의 데이터를 가져오는 함수 => 임시 디렉터리는 캐시(cache)를 이용하므로 앱이 종료되고 일정시간이 지나면 사라질 수 있다.
 */

class FileApp extends StatefulWidget {
  const FileApp({super.key});

  @override
  State<FileApp> createState() => _FileAppState();
}

class _FileAppState extends State<FileApp> {
  int _count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCountFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Example')),
      body: Container(
        child: Center(
            child: Text(
          '$_count',
          style: TextStyle(fontSize: 40),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
          });
          writeCountFile(_count);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void readCountFile() async {
    //count.txt 파일을 읽어 데이터를 다시 정수형으로 변환한수 _count 변수에 저장하는 함수.
    try {
      var dir = await getApplicationDocumentsDirectory();
      var file = await File(dir.path + '/count.txt').readAsString();
      print('file ::: $file');
      setState(() {
        _count = int.parse(file);
      });
    } catch (e) {
      print('error ::: ${e.toString()}');
    }
  }

  void writeCountFile(count) async {
    //내부저장소에 count.txt 파일 안에 _count 값을 문자열 형태로 저장하는 함수
    var dir = await getApplicationDocumentsDirectory();
    File(dir.path + '/count.txt').writeAsStringSync(count.toString());
  }
}
