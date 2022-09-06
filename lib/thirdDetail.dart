import 'package:flutter/material.dart';

class ThirdDetail extends StatefulWidget {
  const ThirdDetail({super.key});

  @override
  State<ThirdDetail> createState() => _ThirdDetailState();
}

class _ThirdDetailState extends State<ThirdDetail> {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments.toString();
    print(args);

    return Scaffold(
      appBar: AppBar(title: Text('세번째 페이지')),
      body: Container(
          child: Center(
        child: Text(
          args,
          style: TextStyle(fontSize: 30),
        ),
      )),
    );
  }
}
