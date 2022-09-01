import 'package:flutter/material.dart';

import '../animalItem.dart';

class FirstApp extends StatelessWidget {
  final List<Animal> list; // Animal List 선언
  FirstApp({Key? key, required this.list}) : super(key: key);

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
                      children: <Widget>[
                        Image.asset(
                          list[position].imagePath!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Text(list[position].animalName!),
                      ],
                    ),
                  ),
                  onTap: () {
                    AlertDialog dialog = AlertDialog(
                      content: Text(
                        '이 동물은 ${list[position].kind} 입니다',
                        style: TextStyle(fontSize: 30.0),
                      ),
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog);
                  },
                  onLongPress: () {
                    list.removeAt(position);
                  },
                );
              },
              itemCount: list.length),
        ),
      ),
    );
  }
}
