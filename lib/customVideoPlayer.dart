import 'package:app/customVideoControlButtons.dart';
import 'package:app/customVideoControls.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final List<String>? videoUrls;
  final int? videoIndex;

  const CustomVideoPlayer({
    @required this.videoUrls,
    @required this.videoIndex,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController controller;
  String? url;

  @override
  void initState() {
    // TODO: implement initState
    url = widget.videoUrls![widget.videoIndex!];

    if (url == null) {
      print('잘못된 형식입니다.');
    }

    controller = VideoPlayerController.network(this.url!);

    controller.addListener(() {
      setState(() {});
    });
    controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('custom videoplayer')),
      body: Container(
        child: Column(children: <Widget>[
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(controller),
                CustomVideoControls(controller: controller),
              ],
            ),
          ),
          CustomVideoControlButtons(
              controller: controller,
              videoUrls: widget.videoUrls,
              videoIndex: widget.videoIndex,
              initVideo: this.initVideo)
        ]),
      ),
    );
  }

  Future initVideo(int index) async {
    final new_controller =
        VideoPlayerController.network(widget.videoUrls![index]);

    if (controller.value.isPlaying) {
      controller.pause();
    }

    controller = new_controller;

    controller.initialize().then((_) {
      setState(() {});
    });
  }
}
