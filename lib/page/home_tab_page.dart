import 'package:bilibili/model/home_model.dart';
import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  final String? name;
  final List<BannerModel>? bannerList;


  HomeTabPage({this.name, this.bannerList});

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name!),
    );
  }
}
