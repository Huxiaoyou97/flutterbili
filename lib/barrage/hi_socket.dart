// 负责与后端进行webSocket通信
import 'package:bilibili/dao/login_dao.dart';
import 'package:bilibili/model/barrage_model.dart';
import 'package:bilibili/util/hi_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';

class HiSocket implements ISocket {
  static const _URL = "wss://api.devio.org/uapi/fa/barrage/";

  IOWebSocketChannel _channel;

  ValueChanged<List<BarrageModel>> _callBack;

  /// 心跳间隔数，根据服务器实际timeout时间来调整，这里Nginx服务器的timeout为60
  int _intervalSeconds = 50;

  @override
  void close() {
    if (_channel!=null) {
      _channel.sink.close();
    }
  }

  @override
  ISocket listen(ValueChanged<List<BarrageModel>> callBack) {
    _callBack = callBack;
    return this;
  }

  @override
  ISocket open(String vid) {
    _channel = IOWebSocketChannel.connect(_URL + vid,
        headers: _headers(), pingInterval: Duration(seconds: _intervalSeconds));
    _channel.stream.handleError((error) {
      print("连接发生错误$error");
    }).listen((message) {
      _handleMessage(message);
    });
    return this;
  }

  @override
  ISocket send(String message) {
    _channel.sink.add(message);
    return this;
  }

  _headers() {
    // 设置请求头校验, 注意留意console的log输出： flutter：received
    Map<String, dynamic> header = {
      HiConstants.authTokenKey: HiConstants.authTokenVal,
      HiConstants.courseFlagK: HiConstants.courseFlagV,
    };
    header[LoginDao.BOARDING_PASS] = LoginDao.getBoardingPass();

    return header;
  }

  /// 处理服务端的返回
  void _handleMessage(message) {
    print("message: $message");
    var result = BarrageModel.fromJsonString(message);
    if (result != null && _callBack != null) {
      _callBack(result);
    }
  }
}

abstract class ISocket {
  /// 和服务器建立连接
  ISocket open(String vid);

  /// 发送内容
  ISocket send(String message);

  /// 接收消息
  ISocket listen(ValueChanged<List<BarrageModel>> callBack);

  /// 关闭连接
  void close();
}
