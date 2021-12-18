import 'dart:async';
import 'dart:math';

import 'package:bilibili/barrage/barrage_view_util.dart';
import 'package:bilibili/barrage/ibarrage.dart';
import 'package:bilibili/model/barrage_model.dart';
import 'package:flutter/material.dart';

import 'barrage_item.dart';
import 'hi_socket.dart';

enum BarrageStatus {
  play,
  pause,
}

/// 弹幕组价
class HiBarrage extends StatefulWidget {
  // 弹幕条数
  final int lineCount;

  // 弹幕视频id
  final String vid;

  // 弹幕对应的速度
  final int speed;

  // 弹幕距离顶部top
  final double top;

  // 弹幕是否自动播放
  final bool autoPlay;

  const HiBarrage(
      {Key key,
      this.lineCount = 4,
      @required this.vid,
      this.speed = 800,
      this.top = 0,
      this.autoPlay = false})
      : super(key: key);

  @override
  HiBarrageState createState() => HiBarrageState();
}

class HiBarrageState extends State<HiBarrage> implements IBarrage {
  HiSocket _hiSocket;

  double _height;

  double _width;

  final List<BarrageItem> _barrageItemList = []; // 弹幕widget集合
  final List<BarrageModel> _barrageModelList = []; // 弹幕数据模型

  int _barrageIndex = 0; // 第几条弹幕
  Random _random = Random();
  BarrageStatus _barrageStatus; // 弹幕状态
  Timer _timer; // 计时器

  @override
  void initState() {
    super.initState();
    _hiSocket = HiSocket();
    _hiSocket.open(widget.vid).listen((value) {
      _handleMessage(value);
    });
  }

  @override
  void dispose() {
    if (_hiSocket != null) {
      _hiSocket.close();
    }
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = _width / 16 * 9;

    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: [
          // 防止Stack的child为空
          Container()
        ]..addAll(_barrageItemList),
      ),
    );
  }

  // 处理消息，instant = true 马上发送
  void _handleMessage(List<BarrageModel> modelList, {bool instant = false}) {
    if (instant) {
      _barrageModelList.insertAll(0, modelList); // 插入最前
    } else {
      _barrageModelList.addAll(modelList); // 插入尾部
    }

    print("_barrageStatus----$_barrageStatus");

    // 收到新的弹幕后播放
    if (_barrageStatus == BarrageStatus.play) {
      play();
      return;
    }
    // 收到新的弹幕后播放
    if (widget.autoPlay && _barrageStatus != BarrageStatus.pause) {
      play();
    }
  }

  @override
  void play() {
    _barrageStatus = BarrageStatus.play;
    print("action:play");
    if (_timer != null && _timer.isActive) return;

    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if (_barrageModelList.isNotEmpty) {
        // 将发送的弹幕在集合中剔除
        var temp = _barrageModelList.removeAt(0);
        addBarrage(temp);
        print("start:${temp.content}");
      } else {
        // 弹幕发送完毕后关闭定时器
        print("弹幕发送完毕");
        _timer.cancel();
      }
    });
  }

  void addBarrage(BarrageModel model) {
    double perRowHeight = 30;
    var line = _barrageIndex % widget.lineCount;
    _barrageIndex++;
    var top = line * perRowHeight + widget.top;
    String id = "${_random.nextInt(10000)}:${model.content}";
    var item = BarrageItem(
      id: id,
      top: top,
      child: BarrageViewUtil.barrageView(model),
      onComplete: _onComplete,
    );
    _barrageItemList.add(item);
    setState(() {});
  }

  @override
  void pause() {
    _barrageStatus = BarrageStatus.pause;
    // 清空屏幕上的弹幕
    _barrageItemList.clear();
    setState(() {});
    print("弹幕暂停");
    _timer.cancel();
  }

  @override
  void send(String message) {
    if (message == null) return;
    _hiSocket.send(message);
    _handleMessage(
        [BarrageModel(content: message, vid: "-1", priority: 1, type: 1)]);
  }

  void _onComplete(id) {
    print("Done:$id");
    _barrageItemList.removeWhere((element) => element.id == id);
  }
}
