import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LargeFileMain extends StatefulWidget {
  const LargeFileMain({super.key});

  @override
  State<LargeFileMain> createState() => _LargeFileMainState();
}

class _LargeFileMainState extends State<LargeFileMain> {
  TextEditingController? _editingController;
  bool downloading = false;
  var progressString = '';
  String file = '';

  @override
  void initState() {
    super.initState();
    _editingController = new TextEditingController(
        text:
            'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg');
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      //getApplicationDocumentsDirectory()함수는 path_provider 패키지가 제공. 플러터 앱의 내부 디렉터리를 가져오는 역할
      var dir = await getApplicationDocumentsDirectory();
      print('dir::: $dir');
      await dio.download(
        //url에 담긴 주소에서 파일 다운로드하고, 내부 디렉터리 안에 myimage.jpg라는 이름으로 저장한다.
        _editingController!.value.text,
        '${dir.path}/myimage.jpg',
        onReceiveProgress: (count, total) {
          //데이터를 받을 때마다, 진행 상황을 표시한다.
          //count는 지금까지 내려받은 데이터, total은 파일의 전체 크기이다.
          print('다운로드 된 데이터 : $count, 전체 데이터 : $total');
          file = '${dir.path}/myimage.jpg';
          setState(() {
            downloading = true;
            progressString = (count / total * 100).toStringAsFixed(0) + '%';
          });
        },
      );
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = 'Completed';
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<Widget> downloadWidget(String filePath) async {
      File file = File(filePath);
      bool exist = await file.exists();
      new FileImage(file).evict();
      //evict()는 캐시 초기화. 플러터는 캐시에 **같은 이름의 이미지**가 있으면 **이미지를 변경하지 않고** 해당 이미지를 사용한다.
      //이때 evict() 함수를 이용하여 캐시를 비우면, 같은 이름이어도 이미지를 갱신한다.
      if (exist) {
        return Center(
          child: Column(
            children: <Widget>[Image.file(file)],
          ),
        );
      } else {
        return Text('No Data');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'url을 입력해주세요!'),
        ),
      ),
      body: Center(
          child: downloading
              ? Container(
                  height: 120,
                  width: 200,
                  child: Card(
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Downloading File: $progressString',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                )
              : FutureBuilder(
                  //FutureBuilder 위젯은 아직 데이터가 없지만, 앞으로 데이터를 받아서 처리한 후 만들겠다는 의미이다.
                  future: downloadWidget(file),
                  builder: (context, snapshot) {
                    //snapshot은 FutureBuilder.future에서 받아온 데이터를 저장한 dynamic 형태의 변수이다.
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        //FutureBuilder.future가 null일 때
                        print('none');
                        return Text('데이터 없음');
                      case ConnectionState.waiting:
                        //연결되기 전 (FutureBuilder.future에서 데이터를 반환받지 않았을 때)
                        print('waiting');
                        return CircularProgressIndicator(); //로딩위젯
                      case ConnectionState.active:
                        //하나 이상의 데이터를 반환받을 때
                        print('active');
                        return CircularProgressIndicator();
                      case ConnectionState.done:
                        //모든 데이터를 받아서 연결이 끝날 때
                        print('done');
                        if (snapshot.hasData) {
                          //snapshot.data는 downloadWidget(file) 함수가 반환하는 데이터이다.
                          return snapshot.data as Widget;
                        }
                    }
                    print('end process');
                    return Text('데이터 없음');
                  },
                )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            downloadFile();
          },
          child: Icon(Icons.file_download)),
    );
  }
}
