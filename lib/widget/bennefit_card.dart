import 'package:bilibili/model/banner_model.dart';
import 'package:bilibili/model/profile_model.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:bilibili/util/toast.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:bilibili/widget/hi_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 增值服务
class BenefitCard extends StatelessWidget {
  final List<Benefit> benefitList;

  const BenefitCard({Key key, @required this.benefitList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [
          _buildTitle(),
          _buildBenefit(context),
        ],
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Text(
            "增值服务",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            "购买后登录慕课网再次点击打开查看",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }

  static bool isUrl(String url) {
    RegExp u = RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+");
    return u.hasMatch(url);
  }

  _buildCard(BuildContext context, Benefit mo, double width) {
    return InkWell(
      onTap: () {
        var url = isUrl(mo.url);
        if (url) {
          HiNavigator.getInstance().openH5(mo.url);
        } else {
          Clipboard.setData(ClipboardData(text: mo.url))
              .then((value) => showSuccessToast("${mo.url}群号已复制到剪贴板"));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: 60,
            decoration: BoxDecoration(color: Colors.deepOrangeAccent),
            child: Stack(
              children: [
                Positioned.fill(child: HiBlur()),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      mo.name,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildBenefit(BuildContext context) {
    // 根据卡片数量计算出每个卡片的宽度
    var width = (MediaQuery.of(context).size.width -
            20 -
            (benefitList.length - 1) * 5) /
        benefitList.length;

    return Row(
      children: [
        ...benefitList.map((e) => _buildCard(context, e, width)).toSet()
      ],
    );
  }

  void _buildCardClick() {}
}
