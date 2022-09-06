import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget {
  const SubDetail({super.key});

  @override
  State<SubDetail> createState() => _SubDetailState();
}

class _SubDetailState extends State<SubDetail> {
  List<String> todoList = new List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoList.add('당근 사오기');
    todoList.add('약 사오기');
    todoList.add('청소하기');
    todoList.add('부모님께 전화하기');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sub Detail Example')),
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                splashColor: Colors.lightGreenAccent,
                child: Text(
                  todoList[index],
                  style: TextStyle(fontSize: 30),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/third', arguments: todoList[index]);
                  //third path로 todo의 데이터 전달
                },
              ),
            );
          },
        ));
  }
}
