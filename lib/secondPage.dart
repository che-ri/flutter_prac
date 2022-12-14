import 'package:flutter/material.dart';
import '../animalItem.dart';

class SecondApp extends StatefulWidget {
  List<Animal> list;

  SecondApp({Key? key, required this.list}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SecondApp();
}

class _SecondApp extends State<SecondApp> {
  int _radioValue = 0;
  final nameController = TextEditingController();
  bool flyExist = false;
  String? _imagePath;

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
                maxLines: 1,
              ),
              Row(children: <Widget>[
                Radio(
                    value: 0, groupValue: _radioValue, onChanged: _radioChange),
                Text('곤충'),
                Radio(
                    value: 1, groupValue: _radioValue, onChanged: _radioChange),
                Text('영장류'),
                Radio(
                    value: 2, groupValue: _radioValue, onChanged: _radioChange),
                Text('포유류'),
              ], mainAxisAlignment: MainAxisAlignment.spaceAround),
              Row(children: <Widget>[
                Text('날수 있나요?'),
                Checkbox(
                    value: flyExist,
                    onChanged: (bool? check) {
                      setState(() {
                        flyExist = check!;
                      });
                    })
              ], mainAxisAlignment: MainAxisAlignment.spaceAround),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          color: _imagePath == 'image/bee.png'
                              ? Colors.blue
                              : null,
                          child: Image.asset('image/bee.png',
                              width: 80, fit: BoxFit.cover)),
                      onTap: () {
                        setState(() {
                          _imagePath = 'image/bee.png';
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          color: _imagePath == 'image/cat.png'
                              ? Colors.blue
                              : null,
                          child: Image.asset('image/cat.png',
                              width: 80, fit: BoxFit.cover)),
                      onTap: () {
                        setState(() {
                          _imagePath = 'image/cat.png';
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          color: _imagePath == 'image/cow.png'
                              ? Colors.blue
                              : null,
                          child: Image.asset('image/cow.png',
                              width: 80, fit: BoxFit.cover)),
                      onTap: () {
                        setState(() {
                          _imagePath = 'image/cow.png';
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          color: _imagePath == 'image/dog.png'
                              ? Colors.blue
                              : null,
                          child: Image.asset('image/dog.png',
                              width: 80, fit: BoxFit.cover)),
                      onTap: () {
                        setState(() {
                          _imagePath = 'image/dog.png';
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          color: _imagePath == 'image/fox.png'
                              ? Colors.blue
                              : null,
                          child: Image.asset('image/fox.png',
                              width: 80, fit: BoxFit.cover)),
                      onTap: () {
                        setState(() {
                          _imagePath = 'image/fox.png';
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          color: _imagePath == 'image/monkey.png'
                              ? Colors.blue
                              : null,
                          child: Image.asset(
                            'image/monkey.png',
                            width: 80,
                            fit: BoxFit.cover,
                          )),
                      onTap: () {
                        setState(() {
                          _imagePath = 'image/monkey.png';
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          color: _imagePath == 'image/pig.png'
                              ? Colors.blue
                              : null,
                          child: Image.asset('image/pig.png',
                              width: 80, fit: BoxFit.cover)),
                      onTap: () {
                        setState(() {
                          _imagePath = 'image/pig.png';
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          color: _imagePath == 'image/wolf.png'
                              ? Colors.blue
                              : null,
                          child: Image.asset('image/wolf.png',
                              width: 80, fit: BoxFit.cover)),
                      onTap: () {
                        setState(() {
                          _imagePath = 'image/wolf.png';
                        });
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  child: Text('동물 추가하기'),
                  onPressed: () {
                    var animal = Animal(
                        animalName: nameController.value.text,
                        kind: getKind(_radioValue),
                        imagePath: _imagePath,
                        flyExist: flyExist);

                    AlertDialog dialog = AlertDialog(
                      title: Text('동물 추가하기'),
                      content: Text(
                        '이 동물은 ${animal.animalName} 입니다 또 동물의 종류는 ${animal.kind}입니다.\n 이 동물을 추가하시겠습니까?',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            widget.list.add(animal);

                            Navigator.of(context).pop();
                          },
                          child: Text('예'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('아니요'),
                        ),
                      ],
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog);
                  })
            ],
          ),
        ),
      ),
    );
  }

  _radioChange(int? value) {
    setState(() {
      _radioValue = value!;
    });
  }

  getKind(int radioValue) {
    switch (radioValue) {
      case 0:
        return "곤충";
      case 1:
        return "영장류";
      case 2:
        return "포유류";
    }
  }
}
