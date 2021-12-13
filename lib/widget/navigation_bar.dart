import 'package:bilibili/util/view_util.dart';
import 'package:flutter/material.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class NavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;

  NavigationBar(
      {this.statusStyle = StatusStyle.DARK_CONTENT,
      this.color = Colors.white,
      this.height = 46,
      this.child});

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  void initState() {
    super.initState();
    _statusBarInit();
  }

  @override
  Widget build(BuildContext context) {
    _statusBarInit();

    // 状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(
        color: widget.color,
      ),
    );
  }

  void _statusBarInit() {
    // 沉浸式状态栏样式
    changeStatusBar(color: widget.color, statusStyle: widget.statusStyle);
  }
}
