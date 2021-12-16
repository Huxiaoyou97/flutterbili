import 'package:bilibili/model/banner_model.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HiBanner extends StatelessWidget {
  final List<BannerModel> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry padding;

  HiBanner(this.bannerList, {this.bannerHeight = 160, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;

    return Swiper(
      itemCount: bannerList.length,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },

      /// 自定义指示器
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: const DotSwiperPaginationBuilder(
            color: Colors.white60,
            size: 6,
            activeSize: 10,
          )),
    );
  }

  _image(BannerModel bannerModel) {
    return InkWell(
      onTap: () {
        print(bannerModel?.title);
        // _handleClick(bannerModel);
        handleBannerClick(bannerModel);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Image.network(
            bannerModel.cover,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  // void _handleClick(BannerModel bannerModel) {
  //   if (bannerModel.type == "video") {
  //     HiNavigator.getInstance().onJumpTo(RouteStatus.detail, args: {
  //       "videoMo": VideoModel(
  //         vid: bannerModel.url,
  //       )
  //     });
  //   } else {
  //     print("banner-type:${bannerModel.type}, url: ${bannerModel.url}");
  //     //TODO
  //   }
  // }
}

///banner点击跳转
void handleBannerClick(BannerModel bannerMo) {
  if (bannerMo.type == 'video') {
    HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
        args: {"videoMo": VideoModel(vid: bannerMo.url)});
  } else {
    HiNavigator.getInstance().openH5(bannerMo.url);
  }
}
