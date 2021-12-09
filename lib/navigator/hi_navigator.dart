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

/// 监听路由页面跳转
/// 感知当前页面是否压后台

class HiNavigator extends _RouteJumpListener {
  static HiNavigator? _instance;

  RouteJumpListener? _routeJump;

  HiNavigator._();

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance!;
  }

  /// 注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    _routeJump = routeJumpListener;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    if (args != null) {
      _routeJump?.onJumpTo(routeStatus, args: args);
    } else {
      _routeJump?.onJumpTo(routeStatus);
    }
  }
}

/// 抽象类提供 HiNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map args});

/// 定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({required this.onJumpTo});
}
