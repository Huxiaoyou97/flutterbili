import 'package:bilibili/model/home_model.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:flutter/material.dart';

/// 可展开的widget
class ExpandableContent extends StatefulWidget {
  final VideoModel videoModel;

  ExpandableContent(this.videoModel);

  @override
  _ExpandableContentState createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  bool _expand = false;

  // 用来管理Animation
  AnimationController _controller;

  // 生成动画高度的值
  Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    _heightFactor = _controller.drive(_easeInTween);

    _controller.addListener(() {
      print(_heightFactor.value);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Column(
        children: [
          _buildTitle(),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
          _buildInfo(),
          _buildDes(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return InkWell(
      onTap: _toggleExpand,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 通过Expanded让Text获得最大宽度，以便显示省略号
          Expanded(
            child: Text(
              widget.videoModel.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 15)),
          Icon(
            _expand
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp,
            color: Colors.grey,
            size: 16,
          )
        ],
      ),
    );
  }

  _toggleExpand() {
    setState(() {
      _expand = !_expand;

      if (_expand) {
        // 执行动画
        _controller.forward();
      } else {
        // 反向执行动画
        _controller.reverse();
      }
    });
  }

  _buildInfo() {
    var style = const TextStyle(fontSize: 12, color: Colors.grey);
    var dateStr = widget.videoModel.createTime.length > 10
        ? widget.videoModel.createTime.substring(5, 10)
        : widget.videoModel.createTime;

    return Row(
      children: [
        ...smallIconText(Icons.ondemand_video, widget.videoModel.view),
        const Padding(padding: EdgeInsets.only(left: 10)),
        ...smallIconText(Icons.list_alt, widget.videoModel.reply),
        Text(
          "   $dateStr",
          style: style,
        )
      ],
    );
  }

  _buildDes() {
    var child = _expand
        ? Text(
            widget.videoModel.desc,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          )
        : null;

    return AnimatedBuilder(
      animation: _controller.view,
      child: child,
      builder: (BuildContext context, Widget child) {
        return Align(
          heightFactor: _heightFactor.value,
          alignment: Alignment.topCenter,
          child: Container(
            // 会撑满宽度后 让内容对齐
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 8),
            child: child,
          ),
        );
      },
    );
  }
}
