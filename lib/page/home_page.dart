import 'package:bilibili/core/hi_state.dart';
import 'package:bilibili/dao/home_dao.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/model/home_model.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:bilibili/page/home_tab_page.dart';
import 'package:bilibili/util/color.dart';
import 'package:bilibili/util/toast.dart';
import 'package:bilibili/widget/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int> onJumpTo;

  const HomePage({Key key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

/// with AutomaticKeepAliveClientMixin  页面来回切换不会被重新创建
class _HomePageState extends HIState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  TabController _controller;

  List<CategoryModel> categoryList = [];
  List<BannerModel> bannerList = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      print("homePage:current---:${current.page}");
      print("homePage:pre---:${pre?.page}");

      if (widget == current.page || current.page is HomePage) {
        print("打开了首页, onResume");
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print("首页被压后台, onPause");
      }
    });

    loadData();
  }

  @override
  void dispose() {
    /// 页面被关闭时移除监听
    HiNavigator.getInstance().removeListener(listener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          NavigationBar(
            height: 50,
            child: _appBar(),
            color: Colors.white,
            statusStyle: StatusStyle.DARK_CONTENT,
          ),
          Container(
            color: Colors.white,
            child: _tabBar(),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: categoryList.map((tab) {
                return HomeTabPage(
                  categoryName: tab.name,
                  bannerList: tab.name == "推荐" ? bannerList : null,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
      controller: _controller,
      isScrollable: true,
      //  tabBar是否可以滚动
      labelColor: Colors.black,
      indicator: const UnderlineIndicator(
        strokeCap: StrokeCap.round,
        borderSide: BorderSide(color: primary, width: 3),
        insets: EdgeInsets.only(left: 15, right: 15),
      ),
      tabs: categoryList.map((tab) {
        return Tab(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              tab.name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        );
      }).toList(),
    );
  }

  void loadData() async {
    try {
      HomeModel result = await HomeDao.get("推荐");

      if (result.categoryList != null) {
        /// tab 长度变化后需要重新创建TabController
        _controller =
            TabController(length: result.categoryList.length, vsync: this);
        setState(() {
          categoryList = result.categoryList;
        });
      }

      if (result.bannerList != null) {
        setState(() {
          bannerList = result.bannerList;
        });
      }
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  Widget _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: const Image(
                height: 46,
                width: 46,
                image: AssetImage("images/avatar.png"),
              ),
            ),
          ),

          /// 输入框 在Row中填充剩余的空间
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 32,
                  alignment: Alignment.centerLeft,
                  child: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                ),
              ),
            ),
          ),
          const Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outlined,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
