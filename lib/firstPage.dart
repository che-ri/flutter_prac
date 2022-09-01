import 'package:flutter/material.dart';
import './animalItem.dart';

class FirstApp extends StatelessWidget {
  final List<Animal>? list;
  FirstApp({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: ListView.builder(
          itemBuilder: (context, position) {
            //ListView.builder는 BuildContext와 int를 반환.
            //BuildCotext : 위젯 트리에서 위젯의 위치를 알려줌
            //int : 아이템의 순번을 의미
            return Card(
              child: Row(children: [
                Image.asset(list![position].imagePath!,
                    height: 100, width: 100, fit: BoxFit.contain),
                Text(list![position].animalName!)
              ]),
            );
          },
          itemCount: list!.length,
        ),
      ),
    ));
  }
}
