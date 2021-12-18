// 弹幕输入界面
import 'package:bilibili/util/color.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:flutter/material.dart';

class BarrageInput extends StatelessWidget {
  final VoidCallback onTabClose;

  const BarrageInput({Key key, @required this.onTabClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // 空白区域点击关闭弹窗
          Expanded(
              child: GestureDetector(
            onTap: () {
              if (onTabClose != null) onTabClose();
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.transparent,
            ),
          )),

          SafeArea(
              child: Container(
            color: Colors.white,
            child: Row(
              children: [
                hiSpace(width: 15),
                _buildInput(editingController, context),
                _buildSendBtn(editingController, context),
              ],
            ),
          ))
        ],
      ),
    );
  }

  _buildInput(TextEditingController editingController, BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: TextField(
        autofocus: true,
        controller: editingController,
        onSubmitted: (value) {
          _send(value, context);
        },
        cursorColor: primary,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding:
              EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
          hintText: "发个友善的弹幕见证当下",
        ),
      ),
    ));
  }

  // 发送消息
  void _send(String text, BuildContext context) {
    if (text.isNotEmpty) {
      if (onTabClose != null) onTabClose();
      Navigator.pop(context, text);
    }
  }

  _buildSendBtn(TextEditingController editingController, BuildContext context) {
    return InkWell(
      onTap: () {
        var text = editingController.text?.trim() ?? "";
        _send(text, context);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: const Icon(
          Icons.send_rounded,
          color: Colors.grey,
        ),
      ),
    );
  }
}
