import 'package:bilibili/dao/login_dao.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/util/string_util.dart';
import 'package:bilibili/widget/appbar.dart';
import 'package:bilibili/widget/login_effect.dart';
import 'package:bilibili/widget/login_input.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback? onJumpToLogin;

  const RegisterPage({Key? key, this.onJumpToLogin}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool protect = false;

  /// 按钮是否可以点击 默认不可点击
  bool loginEnable = false;

  /// 用户名
  String? userName;

  /// 密码
  String? password;

  /// 再次输入密码
  String? rePassword;

  /// 慕课网id
  String? imoocId;

  /// 订单id
  String? orderId;

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
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              "确认密码",
              "请再次输入密码",
              lineStretch: true,
              obscureText: true,
              onChanged: (text) {
                rePassword = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              "慕课网ID",
              "请输入你的慕课网用户ID",
              keyboardType: TextInputType.number,
              onChanged: (text) {
                imoocId = text;
                checkInput();
              },
            ),
            LoginInput(
              "课程订单号",
              "请输入课程订单号后四位",
              lineStretch: true,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                orderId = text;
                checkInput();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: _LoginButton(),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  Widget _LoginButton() {
    return InkWell(
      onTap: () {
        if (loginEnable) {
          // send();

          checkParams();
        } else {
          print("loginEnable is false");
        }
      },
      child: const Text("注册"),
    );
  }

  void send() async {
    try {
      var result =
          await LoginDao.register(userName!, password!, imoocId!, orderId!);
      // var result = await LoginDao.login("huxiaoyou", "Mace0000");
      if (result["code"] == 0) {
        print("注册成功");

        if (widget.onJumpToLogin != null) {
          widget.onJumpToLogin!();
        }
      } else {
        print(result["message"]);
      }
    } on NeedAuth catch (e) {
      print("NeedAuth: $e");
    } on HiNetError catch (e) {
      print("HiNetError: $e");
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = "两次密码不一致";
    } else if (orderId!.length != 4) {
      tips = "请输入订单号的后四位";
    }

    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }
}
