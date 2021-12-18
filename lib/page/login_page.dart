import 'package:bilibili/dao/login_dao.dart';
import 'package:bilibili/db/hi_cache.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:bilibili/provider/theme_provider.dart';
import 'package:bilibili/util/string_util.dart';
import 'package:bilibili/util/toast.dart';
import 'package:bilibili/widget/appbar.dart';
import 'package:bilibili/widget/login_button.dart';
import 'package:bilibili/widget/login_effect.dart';
import 'package:bilibili/widget/login_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
    // String? value = HiCache.getInstance().get<String>("userName");
    // print("value----$value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("密码登录", "注册", () {
        // Provider.of<>(context)
        context.read<ThemeProvider>().setTheme(ThemeMode.dark);
        HiNavigator.getInstance().onJumpTo(RouteStatus.register);
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              "用户名",
              "请输入用户名",
              // editingController: TextEditingController(text: userName),
              onChanged: (text) {
                print(text);
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              obscureText: true,
              onChanged: (text) {
                print(text);
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: LoginButton(
                "登录",
                enable: loginEnable,
                onPressed: _send,
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  _send() async {
    try {
      var result = await LoginDao.login(userName, password);
      if (result["code"] == 0) {
        HiCache.getInstance().setString("userName", userName);
        showSuccessToast("登录成功");
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      } else {
        showErrorToast(result["msg"]);
      }
    } on NeedAuth catch (e) {
      showErrorToast(e.message);
    } on HiNetError catch (e) {
      showErrorToast(e.message);
    }
  }
}
