import 'package:bilibili/dao/profile_dao.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/model/profile_model.dart';
import 'package:bilibili/util/toast.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:bilibili/widget/bennefit_card.dart';
import 'package:bilibili/widget/course_card.dart';
import 'package:bilibili/widget/hi_banner.dart';
import 'package:bilibili/widget/hi_blur.dart';
import 'package:bilibili/widget/hi_fiexible_header.dart';
import 'package:flutter/material.dart';

/// 我的
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  ProfileModel _profileModel;

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // 嵌套滚动组件
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildAppBar(),
          ];
        },
        body: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [
            ..._buildContentList(),
          ],
        ),
      ),
    );
  }

  void _loadData() async {
    try {
      ProfileModel result = await ProfileDao.get();
      print(result);

      setState(() {
        _profileModel = result;
      });
    } on NeedAuth catch (e) {
      showErrorToast(e.message);
    } on HiNetError catch (e) {
      showErrorToast(e.message);
    }
  }

  _buildHead() {
    if (_profileModel == null) return Container();
    return HiFlexibleHeader(
        name: _profileModel.name,
        face: _profileModel.face,
        controller: _controller);
  }

  @override
  bool get wantKeepAlive => true;

  _buildAppBar() {
    return SliverAppBar(
      // 扩展高度
      expandedHeight: 160,
      // 标题栏是否固定
      pinned: true,
      // 定义滚动空间
      flexibleSpace: FlexibleSpaceBar(
        // 视差滚动
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
        background: Stack(
          children: [
            Positioned.fill(
                child: cachedImage(
                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdingyue.nosdn.127.net%2Fniyp0eJFDOGDCJNzc6MmHqQWdNH7eTmk5DNN2V0xO10Ra1522867823306compressflag.jpg&refer=http%3A%2F%2Fdingyue.nosdn.127.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1642313488&t=51cb35efe546c86ab097269f19f95d2f")),
            Positioned.fill(
                child: HiBlur(
              sigma: 20,
            )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildProfileTab(),
            )
          ],
        ),
      ),
    );
  }

  _buildContentList() {
    if (_profileModel == null) return [];
    return [
      _buildBanner(),
      CourseCard(
        courseList: _profileModel.courseList,
      ),
      BenefitCard(benefitList: _profileModel.benefitList,)
    ];
  }

  _buildBanner() {
    return HiBanner(
      _profileModel.bannerList,
      bannerHeight: 120,
      padding: const EdgeInsets.only(left: 10, right: 10),
    );
  }

  _buildProfileTab() {
    if (_profileModel == null) return Container();

    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText("收藏", _profileModel.favorite),
          _buildIconText("点赞", _profileModel.like),
          _buildIconText("浏览", _profileModel.browsing),
          _buildIconText("金币", _profileModel.coin),
          _buildIconText("粉丝数", _profileModel.fans),
        ],
      ),
    );
  }

  _buildIconText(String text, int count) {
    return Column(
      children: [
        Text("$count", style: TextStyle(fontSize: 15, color: Colors.black87)),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
