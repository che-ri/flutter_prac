import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget {
  const SubDetail({super.key});

  @override
  State<SubDetail> createState() => _SubDetailState();
}

class _SubDetailState extends State<SubDetail> {
  List<String> todoList = new List.empty(growable: true);

  void _addNavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/second');
    setState(() {
      //๐๐ผโโ๏ธ ํ์ด์ง์ด๋ํ๋ฉด์ ๋ฐ์ดํฐ ์ฃผ๊ณ ๋ฐ๊ธฐ 1
      //๋ค์ ์ด ํ์ด์ง๋ก ๋์์์ ๋ ๋ฆฌํด๋๋ ๊ฐ์ด ์์ผ๋ฉด, ์ค๋ฅ ๋ฐ์! ๐ฉ
      todoList.add(result as String);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoList.add('๋น๊ทผ ์ฌ์ค๊ธฐ');
    todoList.add('์ฝ ์ฌ์ค๊ธฐ');
    todoList.add('์ฒญ์ํ๊ธฐ');
    todoList.add('๋ถ๋ชจ๋๊ป ์ ํํ๊ธฐ');
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
                //third path๋ก todo์ ๋ฐ์ดํฐ ์ ๋ฌ
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNavigation(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
