import 'package:flutter/material.dart';

class SecondDetail extends StatefulWidget {
  const SecondDetail({super.key});

  @override
  State<SecondDetail> createState() => _SecondDetailState();
}

class _SecondDetailState extends State<SecondDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('두번째 페이지')),
      body: Container(
          child: Center(
        child: ElevatedButton(
            onPressed: () {
              //pushReplacementNamed() 함수는 스택 메모리에 있는 자료를 교체한다.
              Navigator.of(context).pushReplacementNamed('/third');
            },
            child: Text('세 번째 페이지로 이동하기')),
      )),
    );
  }
}
