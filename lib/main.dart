import 'dart:convert';

import 'package:bilibili/dao/login_dao.dart';
import 'package:bilibili/db/hi_cache.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/request/notic_request.dart';
import 'package:bilibili/http/request/test_request.dart';
import 'package:bilibili/model/owner.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:bilibili/page/home_page.dart';
import 'package:bilibili/page/login_page.dart';
import 'package:bilibili/page/register_page.dart';
import 'package:bilibili/page/video_detail_page.dart';
import 'package:bilibili/util/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(

        /// 进行初始化
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(
                  routerDelegate: _routeDelegate,
                )
              : const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

          return MaterialApp(
            home: widget,
            theme: ThemeData(primarySwatch: white),
          );
        });
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  /// 为 Navigator 设置一个key，必要的时候可以通过navigatorKey.currentState来获取NavigatorState对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  /// 当前路由状态
  RouteStatus _routeStatus = RouteStatus.home;

  /// 存放所有的页面
  List<MaterialPage> pages = [];

  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);

    List<MaterialPage> tempPages = pages;

    /// 当前页面是否存在堆栈中 如果存在直接出栈 无需重新创建页面 避免性能消耗
    if (index != -1) {
      /// 要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      /// tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的示例
      tempPages = tempPages.sublist(0, index);
    }

    var page;
    if (routeStatus == RouteStatus.home) {
      /// 跳转到首页时将栈中其它的页面出栈，因为首先不可回退
      pages.clear();
      page = pageWrap(HomePage(
        onJumpToDetail: (videoModel) {
          this.videoModel = videoModel;
          notifyListeners();
        },
      ));
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel!));
    } else if (routeStatus == RouteStatus.register) {
      page = pageWrap(RegisterPage(
        onJumpToLogin: () {
          _routeStatus = RouteStatus.login;
          notifyListeners();
        },
      ));
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }

    /// 重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];

    pages = tempPages;

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        // 在这里可以控制是否可以返回
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.register && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  /// 用户是否登录
  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {}
}

/// 定义路由数据, path
class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}
