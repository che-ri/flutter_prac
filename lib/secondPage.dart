import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import './animalItem.dart';

class SecondApp extends StatefulWidget {
  @override
  State<SecondApp> createState() => _SecondAppState();
  List<Animal>? list;
  SecondApp({Key? key, @required this.list}) : super(key: key);
}

class _SecondAppState extends State<SecondApp> {
  final nameController = TextEditingController();
  int? _radioValue = 0;
  bool? flyExist = false;
  String? _imagePath;

  _radioChange(int? value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLines: 1),
            Row(
              children: [
                Radio(
                    value: 0, groupValue: _radioValue, onChanged: _radioChange),
                Text('곤충'),
                Radio(
                    value: 1, groupValue: _radioValue, onChanged: _radioChange),
                Text('영장류'),
                Radio(
                    value: 2, groupValue: _radioValue, onChanged: _radioChange),
                Text('포유류'),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            Row(
              children: [
                Text('날 수 있나요?'),
                Checkbox(
                    value: flyExist,
                    onChanged: (bool? check) {
                      setState(() {
                        flyExist = check;
                      });
                    })
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    child: Image.asset('image/bee.png', width: 80),
                    onTap: () {
                      _imagePath = 'image/bee.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('image/cat.png', width: 80),
                    onTap: () {
                      _imagePath = 'image/cat.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('image/cow.png', width: 80),
                    onTap: () {
                      _imagePath = 'image/cow.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('image/dog.png', width: 80),
                    onTap: () {
                      _imagePath = 'image/dog.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('image/fox.png', width: 80),
                    onTap: () {
                      _imagePath = 'image/fox.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('image/monkey.png', width: 80),
                    onTap: () {
                      _imagePath = 'image/monkey.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('image/pig.png', width: 80),
                    onTap: () {
                      _imagePath = 'image/pig.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('image/wolf.png', width: 80),
                    onTap: () {
                      _imagePath = 'image/wolf.png';
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text('동물 추가하기'))
          ],
        )),
      ),
    );
  }
}
