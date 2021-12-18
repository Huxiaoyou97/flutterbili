import 'dart:io';

import 'package:bilibili/barrage/hi_socket.dart';
import 'package:bilibili/dao/favorites_dao.dart';
import 'package:bilibili/dao/like_dao.dart';
import 'package:bilibili/dao/video_detail_dao.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/model/home_model.dart';
import 'package:bilibili/model/video_detail_model.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/util/toast.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:bilibili/widget/appbar.dart';
import 'package:bilibili/widget/expandable_content.dart';
import 'package:bilibili/widget/hi_tab.dart';
import 'package:bilibili/widget/navigation_bar.dart';
import 'package:bilibili/widget/video_header.dart';
import 'package:bilibili/widget/video_large_card.dart';
import 'package:bilibili/widget/video_toolbar.dart';
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

  VideoDetailModel videoDetailModel;

  VideoModel videoModel;

  List<VideoModel> videoList = [];

  HiSocket _hiSocket;

  @override
  void initState() {
    super.initState();

    // 黑色状态栏, 仅Android
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);

    _controller = TabController(length: tabs.length, vsync: this);
    videoModel = widget.videoModel;
    _initSocket();
    _loadDetail();
  }

  @override
  void dispose() {
    _controller.dispose();
    _hiSocket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MediaQuery.removePadding(
      context: context,
      removeTop: Platform.isIOS,
      child: videoModel.url != null
          ? Column(
              children: [
                // IOS 黑色状态栏
                NavigationBar(
                  color: Colors.black,
                  statusStyle: StatusStyle.LIGHT_CONTENT,
                  height: Platform.isAndroid ? 0 : 46,
                ),
                _buildVideoView(),
                _buildTabNavigation(),
                // 填充剩余区域
                Flexible(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      _buildDetailList(),
                      Container(
                        child: Text("敬请期待..."),
                      )
                    ],
                  ),
                ),
              ],
            )
          : Container(),
    ));
  }

  _buildVideoView() {
    var model = videoModel;
    return VideoView(
      model.url,
      cover: model.cover,
      autoPlay: false,
      overlayUI: videoAppBar(),
    );
  }

  _buildTabNavigation() {
    // 使用 Material 实现阴影效果
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

  _buildDetailList() {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        ...buildContents(),
        ..._buildVideoList(),
      ],
    );
  }

  // 视频底部构建内容
  buildContents() {
    return [
      VideoHeader(
        owner: videoModel.owner,
      ),
      ExpandableContent(videoModel),
      // 视频点赞收藏工具栏
      VideoToolBar(
        videoDetailModel: videoDetailModel,
        videoModel: videoModel,
        onLike: _onLike,
        onUnLike: _onUnLike,
        onFavorite: _onFavorite,
      )
    ];
  }

  void _loadDetail() async {
    try {
      VideoDetailModel result = await VideoDetailDao.get(videoModel.vid);
      setState(() {
        videoDetailModel = result;
        videoModel = result.videoInfo;
        videoList = result.videoList;
      });
    } on NeedAuth catch (e) {
      showErrorToast(e.message);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  // 喜欢
  void _onLike() async {
    try {
      var result = await LikeDao.like(videoModel.vid, true);
      showSuccessToast(result["msg"]);
      videoDetailModel.isLike = true;
      videoModel.like += 1;

      setState(() {
        videoModel = videoModel;
        videoDetailModel = videoDetailModel;
      });
    } on NeedAuth catch (e) {
      showErrorToast(e.message);
    } on HiNetError catch (e) {
      showErrorToast(e.message);
    }
  }

  // 取消喜欢
  void _onUnLike() async {
    try {
      var result = await LikeDao.like(videoModel.vid, false);
      showSuccessToast(result["msg"]);
      videoDetailModel.isLike = false;
      videoModel.like -= 1;

      setState(() {
        videoModel = videoModel;
        videoDetailModel = videoDetailModel;
      });
    } on NeedAuth catch (e) {
      showErrorToast(e.message);
    } on HiNetError catch (e) {
      showErrorToast(e.message);
    }
  }

  // 收藏 or 取消收藏
  void _onFavorite() async {
    try {
      var result = await FavoriteDao.favorite(
          videoModel.vid, !videoDetailModel.isFavorite);
      videoDetailModel.isFavorite = !videoDetailModel.isFavorite;
      if (videoDetailModel.isFavorite) {
        videoModel.favorite += 1;
      } else {
        videoModel.favorite -= 1;
      }

      setState(() {
        videoModel = videoModel;
        videoDetailModel = videoDetailModel;
      });
      showSuccessToast(result["msg"]);
    } on NeedAuth catch (e) {
      showErrorToast(e.message);
    } on HiNetError catch (e) {
      showErrorToast(e.message);
    }
  }

  _buildVideoList() {
    return videoList
        .map((VideoModel mo) => VideoLargeCard(videoModel: mo))
        .toList();
  }

  void _initSocket() {
    _hiSocket = HiSocket();
    _hiSocket.open(videoModel.vid).listen((value) {
      print("收到----$value");
    });
  }
}
