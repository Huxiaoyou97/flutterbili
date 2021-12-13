import 'package:bilibili/util/color.dart';
import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

/// 顶部 tab 切换
class HiTab extends StatelessWidget {
  /// 需要显示的widget
  final List<Widget> tabs;

  /// TabController
  final TabController controller;

  final double fontSize;

  final double borderWidth;

  final double insets;

  final Color unselectedLabelColor;

  HiTab(this.tabs,
      {Key key,
      this.controller,
      this.fontSize = 13,
      this.borderWidth = 2,
      this.insets = 15,
      this.unselectedLabelColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      //  tabBar是否可以滚动
      labelColor: primary,
      unselectedLabelColor: unselectedLabelColor,
      labelStyle: TextStyle(fontSize: fontSize),
      indicator: UnderlineIndicator(
        strokeCap: StrokeCap.round,
        borderSide: BorderSide(color: primary, width: borderWidth),
        insets: EdgeInsets.only(left: insets, right: insets),
      ),
      tabs: tabs,
    );
  }
}
