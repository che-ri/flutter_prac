import 'package:app/customVideoControls.dart';
import 'package:app/customVideoOverlay.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final List<String>? videoUrls;
  int? videoIndex;

  CustomVideoPlayer({
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

    controller = VideoPlayerController.network(widget.videoUrls![0])
      ..initialize().then((value) => {setState(() {})});

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
                CustomVideoOverlay(controller: controller),
              ],
            ),
          ),
          CustomVideoControls(
              controller: controller,
              videoUrls: widget.videoUrls,
              videoIndex: widget.videoIndex,
              initVideo: initVideo)
        ]),
      ),
    );
  }

  Future initVideo(int index) async {
    String url = widget.videoUrls![widget.videoIndex!];

    if (controller.value.isPlaying) {
      controller.pause();
    }

    controller = VideoPlayerController.network(widget.videoUrls![index])
      ..initialize().then((value) => {setState(() {})});
  }
}
