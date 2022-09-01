import './animalItem.dart'; //model
import './firstPage.dart';
import './secondPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: _title, home: WidgetApp());
  }
}

class WidgetApp extends StatefulWidget {
  @override
  _WidgetApp createState() => _WidgetApp();
}

class _WidgetApp extends State<WidgetApp> with SingleTickerProviderStateMixin {
  TabController? controller;
  List<Animal> animalList =
      new List.empty(growable: true); //growable은 리스트가 가변적으로 증가할 수 있다는 것을 의미한다.
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    animalList
        .add(Animal(animalName: '벌', kind: '곤충', imagePath: 'image/bee.png'));
    animalList.add(
        Animal(animalName: '고양이', kind: '포유류', imagePath: 'image/cat.png'));
    animalList
        .add(Animal(animalName: '젖소', kind: '포유류', imagePath: 'image/cow.png'));
    animalList.add(
        Animal(animalName: '강아지', kind: '포유류', imagePath: 'image/dog.png'));
    animalList
        .add(Animal(animalName: '여우', kind: '포유류', imagePath: 'image/fox.png'));
    animalList.add(
        Animal(animalName: '원숭이', kind: '영장류', imagePath: 'image/monkey.png'));
    animalList
        .add(Animal(animalName: '돼지', kind: '포유류', imagePath: 'image/pig.png'));
    animalList.add(
        Animal(animalName: '늑대', kind: '포유류', imagePath: 'image/wolf.png'));
  }

  @override
  void dispose() {
    controller!
        .dispose(); //탭 컨트롤러는 애니메이션을 사용하므로, dispose() 함수를 호출해줘야 메모리 누수를 막을 수 있다.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller!.addListener(() => {
          //탭이 이동할 때 어떠한 액션을 취하고 싶으면 addListener을 사용한다.
          if (!controller!.indexIsChanging)
            //indexIsChanging은 탭이 현재 이동 중인지를 나타낸다.
            {
              print('prev ::: ${controller!.previousIndex}'),
              print('cur ::: ${controller!.index}')
            }
        });
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Prac'),
        ),
        body: TabBarView(
          children: <Widget>[
            FirstApp(
              list: animalList,
            ),
            SecondApp()
          ],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(
          tabs: <Tab>[
            Tab(
                icon: Icon(
              Icons.looks_one,
              color: Colors.blue,
            )),
            Tab(
                icon: Icon(
              Icons.looks_two,
              color: Colors.blue,
            ))
          ],
          controller: controller,
        ));
  }
}
