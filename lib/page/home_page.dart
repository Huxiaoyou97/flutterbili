import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("首页"),
            MaterialButton(
              onPressed: () {
                HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
                    args: {"videoMo": VideoModel(1001)});
              },
              child: Text("详情"),
            ),
          ],
        ),
      ),
    );
  }
}
