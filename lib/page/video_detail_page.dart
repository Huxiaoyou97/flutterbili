import 'dart:io';

import 'package:bilibili/model/home_model.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:bilibili/widget/appbar.dart';
import 'package:bilibili/widget/hi_tab.dart';
import 'package:bilibili/widget/navigation_bar.dart';
import 'package:bilibili/widget/video_view.dart';
import 'package:flutter/material.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  VideoDetailPage(this.videoModel);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  TabController _controller;

  List tabs = ["简介", "评论288"];

  @override
  void initState() {
    super.initState();

    // 黑色状态栏, 仅Android
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);

    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          _buildVideoView(),
          _buildTabNavigation(),
        ],
      ),
    ));
  }

  _buildVideoView() {
    var model = widget.videoModel;
    return VideoView(
      model.url,
      cover: model.cover,
      autoPlay: false,
      overlayUI: videoAppBar(),
    );
  }

  _buildTabNavigation() {
    return Material(
      elevation: 5, // 阴影大小
      shadowColor: Colors.grey[100], // 阴影颜色
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        height: 40,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs.map<Tab>((name) {
        return Tab(
          text: name,
        );
      }).toList(),

      controller: _controller,
    );
  }
}
