import 'package:bilibili/util/color.dart';
import 'package:flutter/material.dart';

/// 登录输入框 自定义widget

class LoginInput extends StatefulWidget {
  /// 标题
  final String title;

  /// 提示文案
  final String hint;

  /// 内容发生变化 change 事件
  final ValueChanged<String>? onChanged;

  /// 输入框获取焦点事件
  final ValueChanged<bool>? focusChanged;

  /// 输入框底部线条是否撑满一行
  final bool lineStretch;

  /// 是否启用密码输入模式
  final bool obscureText;

  /// 输入框类型 纯数字输入 普通输入 等
  final TextInputType? keyboardType;

  LoginInput(this.title, this.hint,
      {this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType});

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  /// 输入框是否获取到光标
  final _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 是否获取光标的监听
    _focusNode.addListener(() {
      // hasFocus 获取到光标的时候会执行
      print("Has focus: ${_focusNode.hasFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    /// 页面销毁 释放focusNode
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _input(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
          child: const Divider(
            height: 1,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }

  _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      cursorColor: primary, // 光标颜色
      style: const TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      // 输入框的样式
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, right: 20),
        border: InputBorder.none,
        hintText: widget.hint,
        hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
      ),
    ));
  }
}
