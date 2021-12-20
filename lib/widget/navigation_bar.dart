import 'package:bilibili/provider/theme_provider.dart';
import 'package:bilibili/util/color.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class NavigatorBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;

  NavigatorBar(
      {this.statusStyle = StatusStyle.DARK_CONTENT,
      this.color = Colors.white,
      this.height = 46,
      this.child});

  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  var _statusStyle;
  var _color;

  @override
  Widget build(BuildContext context) {
    _statusBarInit();

    var themeProvider = context.watch<ThemeProvider>();
    if (themeProvider.isDark()) {
      _color = HiColor.dark_bg;
      _statusStyle = StatusStyle.LIGHT_CONTENT;
    } else {
      _color =widget.color;
      _statusStyle = widget.statusStyle;
    }
    _statusBarInit();
    // 状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(
        color: _color,
      ),
    );
  }

  void _statusBarInit() {
    // 沉浸式状态栏样式
    changeStatusBar(color: _color, statusStyle: _statusStyle);
  }
}
