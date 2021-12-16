import 'package:bilibili/model/video_model.dart';

class HomeModel {
  HomeModel({
    this.bannerList,
    this.categoryList,
    this.videoList,
  });

  List<BannerModel> bannerList;
  List<CategoryModel> categoryList;
  List<VideoModel> videoList;

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['bannerList'] != null) {
      bannerList = List<BannerModel>.empty(growable: true);
      json['bannerList'].forEach((v) {
        bannerList.add(BannerModel.fromJson(v));
      });
    }
    if (json['categoryList'] != null) {
      categoryList = List<CategoryModel>.empty(growable: true);
      json['categoryList'].forEach((v) {
        categoryList.add(CategoryModel.fromJson(v));
      });
    }
    if (json['videoList'] != null) {
      videoList = List<VideoModel>.empty(growable: true);
      json['videoList'].forEach((v) {
        videoList.add(VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        "bannerList": List<dynamic>.from(bannerList.map((x) => x.toJson())),
        "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
        "videoList": List<dynamic>.from(videoList.map((x) => x.toJson())),
      };
}

class BannerModel {
  BannerModel({
    this.id,
    this.sticky,
    this.type,
    this.title,
    this.subtitle,
    this.url,
    this.cover,
    this.createTime,
  });

  String id;
  int sticky;
  String type;
  String title;
  String subtitle;
  String url;
  String cover;
  String createTime;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        sticky: json["sticky"],
        type: json["type"],
        title: json["title"],
        subtitle: json["subtitle"],
        url: json["url"],
        cover: json["cover"],
        createTime: json["createTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sticky": sticky,
        "type": type,
        "title": title,
        "subtitle": subtitle,
        "url": url,
        "cover": cover,
        "createTime": createTime,
      };
}

class CategoryModel {
  CategoryModel({
    this.name,
    this.count,
  });

  String name;
  int count;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
      };
}


