import 'package:flutter/material.dart';

import '../animalItem.dart';

class FirstApp extends StatefulWidget {
  List<Animal> list;
  FirstApp({Key? key, required this.list}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FirstApp();
}

class _FirstApp extends State<FirstApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(
              itemBuilder: (context, position) {
                //ListView.builder는 BuildContext와 int를 반환.
                //BuildCotext : 위젯 트리에서 위젯의 위치를 알려줌
                //int : 아이템의 순번을 의미. 여기에서는 position이라는 이름으로 정의했다.
                return GestureDetector(
                  //GestureDetector : 터치이벤트를 처리하기 위한 위젯
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          widget.list[position].imagePath!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Text(widget.list[position].animalName!),
                        ElevatedButton(
                          child: Text('삭제'),
                          onPressed: () {
                            setState(() {
                              widget.list.removeAt(position);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    AlertDialog dialog = AlertDialog(
                      content: Text(
                        '이 동물은 ${widget.list[position].kind} 입니다',
                        style: TextStyle(fontSize: 30.0),
                      ),
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog);
                  },
                );
              },
              itemCount: widget.list.length),
        ),
      ),
    );
  }
}
