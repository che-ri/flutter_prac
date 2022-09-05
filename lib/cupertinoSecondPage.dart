import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'animalItem.dart';

class CupertinoSecondPage extends StatefulWidget {
  final List<Animal>? animalList;
  const CupertinoSecondPage({Key? key, required this.animalList})
      : super(key: key);

  @override
  State<CupertinoSecondPage> createState() => _CupertinoSecondPageState();
}

class _CupertinoSecondPageState extends State<CupertinoSecondPage> {
  TextEditingController? _textController;
  int _kindChoice = 0;
  bool _flyExist = false;
  String? _imagePath;

  Map<int, Widget> segmentWidgets = {
    0: SizedBox(
      width: 80,
      child: Text(
        '양서류',
        textAlign: TextAlign.center,
      ),
    ),
    1: SizedBox(
      width: 80,
      child: Text(
        '포유류',
        textAlign: TextAlign.center,
      ),
    ),
    2: SizedBox(
      width: 80,
      child: Text(
        '파충류',
        textAlign: TextAlign.center,
      ),
    )
  };

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('동물 추가'),
        ),
        child: Container(
          child: Center(
              child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: CupertinoTextField(
                  controller: _textController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              ),
              CupertinoSegmentedControl(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  groupValue: _kindChoice,
                  children: segmentWidgets,
                  onValueChanged: (int value) {
                    setState(() {
                      _kindChoice = value;
                    });
                  }),
              Row(
                children: <Widget>[
                  Text('날개가 존재합니까?'),
                  CupertinoSwitch(
                    value: _flyExist,
                    onChanged: (value) {
                      setState(() {
                        _flyExist = !_flyExist;
                      });
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      child: Image.asset('image/cow.png'),
                      onTap: () {
                        _imagePath = 'image/cow.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('image/pig.png'),
                      onTap: () {
                        _imagePath = 'image/pig.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('image/bee.png'),
                      onTap: () {
                        _imagePath = 'image/bee.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('image/cat.png'),
                      onTap: () {
                        _imagePath = 'image/cat.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('image/fox.png'),
                      onTap: () {
                        _imagePath = 'image/fox.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('image/monkey.png'),
                      onTap: () {
                        _imagePath = 'image/monkey.png';
                      },
                    )
                  ],
                ),
              ),
              CupertinoButton(
                child: Text('동물 추가하기'),
                onPressed: () {
                  widget.animalList?.add(Animal(
                      animalName: _textController?.value.text,
                      kind: getKind(_kindChoice),
                      imagePath: _imagePath,
                      flyExist: _flyExist));
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )),
        ));
  }
}

getKind(int radioValue) {
  switch (radioValue) {
    case 0:
      return '양서류';
    case 1:
      return '파충류';
    case 2:
      return '포유류';
  }
}
