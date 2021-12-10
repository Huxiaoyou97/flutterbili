import 'package:bilibili/model/home_model.dart';
import 'package:bilibili/widget/hi_banner.dart';
import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  final String name;
  final List<BannerModel> bannerList;

  HomeTabPage({this.name, this.bannerList});

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [if (widget.bannerList != null) _banner()],
    );
  }

  _banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(widget.bannerList),
    );
  }
}
