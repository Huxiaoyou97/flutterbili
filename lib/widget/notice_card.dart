import 'package:bilibili/model/banner_model.dart';
import 'package:bilibili/util/format_util.dart';
import 'package:bilibili/util/view_util.dart';
import 'package:bilibili/widget/hi_banner.dart';
import 'package:flutter/material.dart';

class NoticeCard extends StatelessWidget {
  final BannerModel bannerModel;

  const NoticeCard({Key key, @required this.bannerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handleBannerClick(bannerModel);
      },
      child: Container(
        decoration: BoxDecoration(border: borderLine(context)),
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_buildIcon(), hiSpace(width: 10), _buildContents()],
        ),
      ),
    );
  }

  _buildIcon() {
    var iconData = bannerModel.type == 'video'
        ? Icons.ondemand_video_outlined
        : Icons.card_giftcard;

    return Icon(
      iconData,
      size: 30,
    );
  }

  _buildContents() {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bannerModel.title,
                style: const TextStyle(fontSize: 16),
              ),
              Text(dateMonthAndDay(bannerModel.createTime))
            ],
          ),
          hiSpace(height: 5),
          Text(
            bannerModel.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
