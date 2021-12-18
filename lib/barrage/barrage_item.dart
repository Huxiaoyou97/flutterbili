import 'package:flutter/material.dart';

import 'barrage_transition.dart';

// 弹幕 widget
class BarrageItem extends StatelessWidget {
  final String id;
  final double top;
  final Widget child;
  final ValueChanged onComplete;
  final Duration duration;

  BarrageItem(
      {Key key,
      this.id,
      this.top,
      this.child,
      this.onComplete,
      this.duration = const Duration(milliseconds: 9000)})
      : super(key: key);

  // fix 动画状态错乱
  var _key = GlobalKey<BarrageTransitionState>();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BarrageTransition(
        key: _key,
        child: child,
        onComplete: (v) {
          onComplete(id);
        },
        duration: duration,
      ),
      top: top,
    );
  }
}
