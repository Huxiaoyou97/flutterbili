import 'package:bilibili/core/hi_base_tabs_state.dart';
import 'package:bilibili/dao/ranking_dao.dart';
import 'package:bilibili/model/ranking_model.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/widget/loading_container.dart';
import 'package:bilibili/widget/video_large_card.dart';
import 'package:flutter/material.dart';

class RankingTabPage extends StatefulWidget {
  final String sort;

  const RankingTabPage({Key key, @required this.sort}) : super(key: key);

  @override
  _RankingTabPageState createState() => _RankingTabPageState();
}

class _RankingTabPageState
    extends HiBaseTabState<RankingModel, VideoModel, RankingTabPage> {
  bool _isLoading = true;

  @override
  // TODO: implement contentChild
  get contentChild => LoadingContainer(
        cover: true,
        isLoading: _isLoading,
        child: Container(
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: dataList.length,
              controller: scrollController,
              itemBuilder: (BuildContext context, int index) =>
                  VideoLargeCard(videoModel: dataList[index])),
        ),
      );

  @override
  Future<RankingModel> getData(int pageIndex) async {
    RankingModel result =
        await RankingDao.get(widget.sort, pageIndex: pageIndex, pageSize: 20);
    _isLoading = false;
    return result;
  }

  @override
  List<VideoModel> parseList(RankingModel result) {
    return result.list;
  }
}
