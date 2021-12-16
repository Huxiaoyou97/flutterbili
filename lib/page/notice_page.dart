import 'package:bilibili/core/hi_base_tabs_state.dart';
import 'package:bilibili/core/hi_state.dart';
import 'package:bilibili/dao/notice_dao.dart';
import 'package:bilibili/model/banner_model.dart';
import 'package:bilibili/model/notice_model.dart';
import 'package:bilibili/widget/notice_card.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState
    extends HiBaseTabState<NoticeModel, BannerModel, NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildNavigationBar(),
          Expanded(child: super.build(context))
        ],
      ),
    );
  }

  _buildNavigationBar() {
    return AppBar(
      title: Text("通知"),
    );
  }

  @override
  // TODO: implement contentChild
  get contentChild => ListView.builder(
        itemCount: dataList.length,
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => NoticeCard(
          bannerModel: dataList[index],
        ),
      );

  @override
  Future<NoticeModel> getData(int pageIndex) async {
    var result = await NoticeDao.get(pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<BannerModel> parseList(NoticeModel result) {
    return result.list;
  }
}
