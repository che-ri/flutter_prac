import 'package:flutter/material.dart';

class SecondDetail extends StatefulWidget {
  const SecondDetail({super.key});

  @override
  State<SecondDetail> createState() => _SecondDetailState();
}

class _SecondDetailState extends State<SecondDetail> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();

    return Scaffold(
        appBar: AppBar(title: Text('두번째 페이지')),
        body: Container(
            child: Center(
                child: Container(
          child: Column(children: <Widget>[
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
            ),
            ElevatedButton(
                onPressed: () {
                  //💁🏼‍♀️ 페이지이동하면서 데이터 주고받기 2
                  Navigator.of(context).pop(controller.value.text);
                },
                child: Text('저장하기'))
          ]),
        ))));
  }
}
