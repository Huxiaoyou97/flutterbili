import 'package:bilibili/widget/appbar.dart';
import 'package:bilibili/widget/login_effect.dart';
import 'package:bilibili/widget/login_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  final VoidCallback? onJumpToLogin;

  LoginPage({this.onJumpToLogin});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;

  /// 按钮是否可以点击 默认不可点击
  bool loginEnable = false;

  /// 用户名
  String userName;

  /// 密码
  String password;

  /// 再次输入密码
  String rePassword;

  /// 慕课网id
  String imoocId;

  /// 订单id
  String orderId;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", widget.onJumpToLogin!),
      body: Container(
        child: ListView(
          // 自适应键盘弹起  防止遮挡
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChanged: (text) {
                userName = text;
                checkInput();
                print("LoginInput: $text");
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
                print("LoginInput: $text");
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {}
}
