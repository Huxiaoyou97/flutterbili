import 'dart:io';

import 'package:bilibili/model/home_model.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:bilibili/widget/appbar.dart';
import 'package:bilibili/widget/navigation_bar.dart';
import 'package:bilibili/widget/video_view.dart';
import 'package:flutter/material.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  VideoDetailPage(this.videoModel);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    super.initState();

    // 黑色状态栏, 仅Android
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MediaQuery.removePadding(
      context: context,
      removeTop: Platform.isIOS,
      child: Column(
        children: [
          // IOS 黑色状态栏
          NavigationBar(
            color: Colors.black,
            statusStyle: StatusStyle.LIGHT_CONTENT,
            height: Platform.isAndroid ? 0 : 46,
          ),
          _videoView(),
          Text('视频详情页: vid:${widget.videoModel.vid}'),
          Text('视频详情页: vid:${widget.videoModel.title}'),
        ],
      ),
    ));
  }

  _videoView() {
    var model = widget.videoModel;
    return VideoView(
      model.url,
      cover: model.cover,
      autoPlay: false,
      overlayUI: videoAppBar(),
    );
  }
}
