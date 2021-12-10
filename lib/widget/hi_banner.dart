import 'package:bilibili/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HiBanner extends StatelessWidget {
  final List<BannerModel> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry padding;

  HiBanner(this.bannerList, { this.bannerHeight = 160, this.padding});

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
    );
  }

  _image(BannerModel bannerModel) {
    return InkWell(
      onTap: () {
        print(bannerModel?.title);
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
}
