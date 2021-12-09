import 'package:bilibili/page/home_page.dart';
import 'package:bilibili/page/login_page.dart';
import 'package:bilibili/page/register_page.dart';
import 'package:bilibili/page/video_detail_page.dart';
import 'package:flutter/material.dart';

/// 创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

/// 自定义路由封装，路由状态
enum RouteStatus { login, register, home, detail, unknown }

/// 获取routeStatus在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

/// 获取path对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegisterPage) {
    return RouteStatus.register;
  } else if (page.child is RegisterPage) {
    return RouteStatus.login;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else {
    return RouteStatus.unknown;
  }
}

/// 路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}
