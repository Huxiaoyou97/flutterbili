import 'package:bilibili/util/color.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

import 'hi_video_controls.dart';

/// 播放器组件
class VideoView extends StatefulWidget {
  /// 播放地址
  final String url;

  /// 视频封面地址
  final String cover;

  /// 是否自动播放
  final bool autoPlay;

  /// 是否循环播放
  final bool looping;

  /// 视频缩放比例
  final double aspectRatio;

  final Widget overlayUI;

  VideoView(this.url,
      {this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16 / 9,
      this.overlayUI});

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController _videoPlayerController; // video_player 播放器 Controller
  ChewieController _chewieController; // chewie 播放器 Controller

  // 封面
  get _placeholder => FractionallySizedBox(
        widthFactor: 1,
        child: cachedImage(widget.cover),
      );

  // 进度条颜色
  get _progressColors => ChewieProgressColors(
        playedColor: primary,
        handleColor: primary,
        backgroundColor: Colors.grey,
        bufferedColor: primary[50],
      );

  @override
  void initState() {
    super.initState();

    /// 初始化播放器设置
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.aspectRatio,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        allowMuting: false,
        placeholder: _placeholder,
        allowPlaybackSpeedChanging: false,
        customControls: MaterialControls(
          showLoadingOnInitialize: false,
          showBigPlayIcon: false,
          bottomGradient: blackLinearGradient(),
          overlayUI: widget.overlayUI,
        ),
        materialProgressColors: _progressColors);

    _chewieController.addListener(_fullScreenListener);
  }

  @override
  void dispose() {
    _chewieController.removeListener(_fullScreenListener);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screendWidth = MediaQuery.of(context).size.width;
    double playerHeight = screendWidth / widget.aspectRatio;

    return Container(
      width: screendWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  void _fullScreenListener() {
    Size size = MediaQuery.of(context).size;

    if (size.width > size.height) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}
