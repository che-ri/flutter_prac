import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoControls extends StatelessWidget {
  VideoPlayerController? controller;
  final List<String>? videoUrls;
  final int? videoIndex;
  final initVideo;

  CustomVideoControls({
    @required this.controller,
    @required this.videoUrls,
    @required this.videoIndex,
    @required this.initVideo,
    Key? key,
  }) : super(key: key);

  @override
  build(BuildContext context) {
    Future prevVideo(int index, List<String> videoUrls) async {
      bool isFirst = index <= 0 ? true : false;
      if (isFirst) {
        print('첫 동영상입니다.');
      } else {
        initVideo(index - 1);
      }
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildButton(Icon(Icons.fast_rewind),
              () => prevVideo(videoIndex!, videoUrls!)),
          SizedBox(width: 12),
          buildButton(Icon(Icons.replay_5), rewind5Seconds),
          SizedBox(width: 12),
          buildButton(Icon(Icons.forward_5), forward5Seconds),
          SizedBox(width: 12),
          buildButton(Icon(Icons.fast_forward),
              () => nextVideo(videoIndex!, videoUrls!)),
        ],
      ),
    );
  }

  buildButton(child, Function onPressed) => Container(
        height: 50,
        width: 50,
        child: ElevatedButton(
          child: child,
          onPressed: () => onPressed(),
        ),
      );

  Future forward5Seconds() async =>
      goToPosition((currentPosition) => currentPosition + Duration(seconds: 5));

  Future rewind5Seconds() async =>
      goToPosition((currentPosition) => currentPosition - Duration(seconds: 5));

  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await controller!.position;
    final newPosition = builder(currentPosition!);
    await controller!.seekTo(newPosition);
  }

  Future nextVideo(int index, List<String> videoUrls) async {
    bool isLast = index >= videoUrls.length - 1 ? true : false;
    if (isLast) {
      print('마지막 동영상입니다.');
    } else {
      initVideo(index + 1);
    }
  }
}
