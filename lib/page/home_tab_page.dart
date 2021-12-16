import 'package:bilibili/dao/home_dao.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/model/home_model.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/util/color.dart';
import 'package:bilibili/util/toast.dart';
import 'package:bilibili/widget/hi_banner.dart';
import 'package:bilibili/widget/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<BannerModel> bannerList;

  HomeTabPage({this.categoryName, this.bannerList});

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

// 列表常驻缓存 AutomaticKeepAliveClientMixin
class _HomeTabPageState extends State<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  List<VideoModel> videoList = [];

  final ScrollController _scrollController = ScrollController();

  int pageIndex = 1;

  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      var dis = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      print("dis:$dis");
      // 当距离底部不足300时 加载更多
      if (dis < 300 && !_loading) {
        _loadData(loadMore: true);
      }
    });
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 使用mixin 请调用super 否则会有警告出现
    return RefreshIndicator(
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          crossAxisCount: 2,
          itemCount: videoList.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return widget.bannerList != null ? _banner() : Container();
            } else {
              return VideoCard(
                videoModel: videoList[index - 1],
              );
            }
          },
          staggeredTileBuilder: (int index) {
            if (widget.bannerList != null && index == 0) {
              return const StaggeredTile.fit(2);
            } else {
              return const StaggeredTile.fit(1);
            }
          },
        ),
      ),
      onRefresh: _loadData,
      color: primary,
    );
  }

  _banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
      child: HiBanner(widget.bannerList),
    );
  }

  Future _loadData({loadMore = false}) async {
    _loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }

    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    print("currentIndex---$currentIndex");
    try {
      HomeModel result = await HomeDao.get(widget.categoryName,
          pageIndex: currentIndex, pageSize: 10);

      setState(() {
        if (loadMore) {
          if (result.videoList.isNotEmpty) {
            videoList = [...videoList, ...result.videoList];
            pageIndex++;
          }
        } else {
          videoList = result.videoList;
        }
      });

      Future.delayed(const Duration(milliseconds: 1000), () {
        _loading = false;
      });
    } on NeedAuth catch (e) {
      _loading = false;
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      _loading = false;
      print(e);
      showWarnToast(e.message);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
