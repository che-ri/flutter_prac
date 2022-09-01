import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Image Widget')),
        body: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'image/flutter_logo.png',
                width: 200,
                height: 100,
                fit:
                    //넓이와 높이를 직접 지정해야 할 때 fit을 이용하면 원하는 형태로 표시할 수 있다.
                    BoxFit.fill, //width, hㄴeight를 가득 채우서 그린다.
                // BoxFit.contain //이미지가 잘리지 않고, 비율이 변하지 않는 범위에서 가능한 한 크게 그린다.
                // BoxFit.cover //비율을 유지한 채 지정한 범위를 모두 덮도록 그린다. 이미지가 잘릴 수 있다.
                // BoxFit.fitWidth //width를 꽉 채워서 그린다. 이미지가 잘릴 수 있다.
                // BoxFit.fitHeight //height를 꽉 채워서 그린다. 이미지가 잘릴 수 있다.
                // BoxFit.none //원본 이미지를 표시한다. 이미지가 잘릴 수 있다.
                // BoxFit.scaleDown //전체 이미지가 나올 수 있게 이미지 크기를 조절해서 표시한다.
              )
            ],
          ),
        )));
  }
}
