// 弹幕移动动效
import 'package:flutter/material.dart';

class BarrageTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final ValueChanged onComplete;

  const BarrageTransition(
      {Key key,
      @required this.child,
      @required this.duration,
      @required this.onComplete})
      : super(key: key);

  @override
  BarrageTransitionState createState() => BarrageTransitionState();
}

class BarrageTransitionState extends State<BarrageTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // 创建动画控制器
    _animationController =
        AnimationController(vsync: this, duration: widget.duration)
          ..addStatusListener((status) {
            // 动画执行完毕之后的回调
            if (status == AnimationStatus.completed) {
              widget.onComplete('');
            }
          });

    // 自定义从右到左的补间动画
    var begin = const Offset(1, 0);
    var end = const Offset(-1, 0);

    _animation = Tween(begin: begin, end: end).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
