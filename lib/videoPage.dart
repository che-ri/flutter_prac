import 'dart:async';
import 'package:better_player/better_player.dart';
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late BetterPlayerController _betterPlayerController;
  Timer? timer;
  static const maxSeconds = 3;
  int seconds = maxSeconds;

  @override
  void initState() {
    print('start');
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
            aspectRatio: 16 / 9, fit: BoxFit.contain, handleLifecycle: true);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, Constants.elephantDreamVideoUrl);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video player"),
      ),
      body: Column(
        children: [
          Wrap(children: [
            TextButton(
                child: Text("SKIP"), onPressed: _betterPlayerController.play),
          ]),
          BetterPlayer(controller: _betterPlayerController),
          buildTime(),
          Wrap(
            children: [
              TextButton(
                  child: Text("시작"),
                  onPressed: () {
                    startTimer();
                  }),
              TextButton(
                  child: Text("정지"),
                  onPressed: () {
                    _betterPlayerController.pause();
                    _betterPlayerController.seekTo(Duration(seconds: 0));
                  }),
              TextButton(
                  child: Text("일시정지"),
                  onPressed: _betterPlayerController.pause),
              TextButton(
                  child: Text("5초이전"),
                  onPressed: () async {
                    var position = await _betterPlayerController
                        .videoPlayerController!.position;
                    var new_position = position! - Duration(seconds: 5);
                    _betterPlayerController.seekTo(new_position);
                  }),
              TextButton(
                  child: Text("5초이후"),
                  onPressed: () async {
                    var position = await _betterPlayerController
                        .videoPlayerController!.position;
                    var new_position = position! + Duration(seconds: 5);
                    _betterPlayerController.seekTo(new_position);
                  }),
              TextButton(
                child: Text("전체보기"),
                onPressed: () {
                  _betterPlayerController.enterFullScreen();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTime() {
    return Text(
      '$seconds',
      style: TextStyle(fontSize: 50),
    );
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        seconds--;
      });

      if (seconds <= 0) {
        timer!.cancel();
        _betterPlayerController.play();

        setState(() {
          seconds = 3;
        });
      }
    });
  }
}
