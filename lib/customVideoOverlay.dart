import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoOverlay extends StatelessWidget {
  final VideoPlayerController? controller;

  const CustomVideoOverlay({
    Key? key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(controller!.value.isPlaying);
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller!.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller!.value.isPlaying
                ? controller!.pause()
                : controller!.play();
          },
        ),
      ],
    );
    ;
  }
}
