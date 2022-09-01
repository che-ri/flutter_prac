import 'package:app/firstPage.dart'; //첫번째 페이지
import 'package:app/secondPage.dart'; //두번째 페이지
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
  //with 키워드는 여러 클래스를 재사용하게끔 해준다.
  //SingleTickerProviderStateMixin을 추가로 상속하면서 위젯이 **애니메이션 동작**을 처리할 수 있게 한 것임. 상속하지 않으면 탭컨트롤러를 만들 수 없음.

  TabController? controller; //여러 화면을 이동하는 역할을 하므로 기본적으로 **애니메이션**을 사용한다.
  @override
  void initState() {
    super.initState();
    controller = TabController(
        length: 2,
        vsync:
            this); //length: 탭의 갯수, vsync : 탭이 이동했을 때 호출되는 콜백 함수를 어디서 처리할지 지정.
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
          children: <Widget>[FirstApp(), SecondApp()],
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
