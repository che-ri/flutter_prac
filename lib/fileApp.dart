import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> itemList = List.empty(growable: true);
  TextEditingController controller = new TextEditingController();

  Future<List<String>> readListFile() async {
    var key = 'first';
    List<String> result = List.empty(growable: true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? firstCheck =
        pref.getBool(key); //파일을 처음 열었는지 확인하는 용도로 **공유환경설정**에 저장한다.
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path + '/fruit.txt')
        .exists(); //내부 저장소에 fruit.txt 파일이 있는지 확인하는 값

    print('firstCheck ::: $firstCheck');
    print('fileExist ::: $fileExist');
    if (firstCheck == null || firstCheck == false || fileExist == false) {
      //repo/fruit.txt 파일을 읽은 후, 내부 저장소 fruit.txt에 저장하고, 그 값을 itemList에 복사한다.
      pref.setBool(key, true); //공유환경설정에 first : true 저장.

      String file =
          await DefaultAssetBundle.of(context).loadString('repo/fruit.txt');
      File(dir.path + '/fruit.txt').writeAsStringSync(file);
      List<String> array =
          file.split('\n'); //문자열인 fruit 데이터를 띄어쓰기를 기준으로 나누어 배열에 담는다.
      result.addAll(array);
      return result;
    } else {
      // fruit.txt을 읽고, itemList에 복사한다.
      String file = await File(dir.path + '/fruit.txt').readAsString();
      List<String> array = file.split('\n');
      result.addAll(array);
      return result;
    }
  }

  void initData() async {
    List<String> result = await readListFile();

    setState(() {
      itemList.addAll(result);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Example')),
      body: Container(
          child: Center(
              child: Column(children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.text,
        ),
        //ListView의 'Vertical viewport was given unbounded height' 이슈가 나오면 Expended 위젯을 이용하자.
        //Expended 위젯은 남은 공간을 모두 사용한다.
        Expanded(
            child: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return Card(
              child: Center(
                child: Text(itemList[index], style: TextStyle(fontSize: 30)),
              ),
            );
          },
        )),
      ]))),
    );
  }
}
