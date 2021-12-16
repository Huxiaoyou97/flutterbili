import 'package:bilibili/core/hi_base_tabs_state.dart';
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
class _HomeTabPageState
    extends HiBaseTabState<HomeModel, VideoModel, HomeTabPage> {
  @override
  void initState() {
    super.initState();
    print(widget.categoryName);
    print(widget.bannerList);
  }

  _banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
      child: HiBanner(widget.bannerList),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  get contentChild => StaggeredGridView.countBuilder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        crossAxisCount: 2,
        itemCount: dataList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return widget.bannerList != null ? _banner() : Container();
          } else {
            return VideoCard(
              videoModel: dataList[index - 1],
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
      );

  @override
  Future<HomeModel> getData(int pageIndex) async {
    HomeModel result = await HomeDao.get(widget.categoryName,
        pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(HomeModel result) {
    return result.videoList;
  }
}
