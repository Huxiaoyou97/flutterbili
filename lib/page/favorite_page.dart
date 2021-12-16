import 'package:bilibili/core/hi_base_tabs_state.dart';
import 'package:bilibili/dao/favorites_dao.dart';
import 'package:bilibili/model/favorite_model.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:bilibili/page/video_detail_page.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:bilibili/widget/loading_container.dart';
import 'package:bilibili/widget/navigation_bar.dart';
import 'package:bilibili/widget/video_large_card.dart';
import 'package:flutter/material.dart';

// 我的收藏
class FavoritePage extends StatefulWidget {
  const FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState
    extends HiBaseTabState<FavoriteModel, VideoModel, FavoritePage> {
  RouteChangeListener listener;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      if (pre?.page is VideoDetailPage && current?.page is FavoritePage) {
        loadData();
      }
    });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
      cover: true,
      isLoading: _isLoading,
      child: Column(
        children: [
          _buildNavigationBar(),
          Expanded(child: super.build(context))
        ],
      ),
    );
  }

  @override
  get contentChild => ListView.builder(
      itemCount: dataList.length,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) =>
          VideoLargeCard(videoModel: dataList[index]));

  @override
  Future<FavoriteModel> getData(int pageIndex) async {
    FavoriteModel result =
        await FavoriteDao.favorites(pageIndex: pageIndex, pageSize: 10);

    _isLoading = false;

    return result;
  }

  @override
  List<VideoModel> parseList(FavoriteModel result) {
    return result.list;
  }

  _buildNavigationBar() {
    return NavigationBar(
      child: Container(
        alignment: Alignment.center,
        child: const Text(
          "收藏",
          style: TextStyle(fontSize: 16),
        ),
        decoration: bottomBoxShadow(),
      ),
    );
  }
}
