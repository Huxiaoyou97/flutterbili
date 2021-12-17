// 个人中心Model
import 'package:bilibili/model/banner_model.dart';

class ProfileModel {
  ProfileModel({
    this.name,
    this.face,
    this.fans,
    this.favorite,
    this.like,
    this.coin,
    this.browsing,
    this.bannerList,
    this.courseList,
    this.benefitList,
  });

  String name;
  String face;
  int fans;
  int favorite;
  int like;
  int coin;
  int browsing;
  List<BannerModel> bannerList;
  List<Course> courseList;
  List<Benefit> benefitList;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    name: json["name"],
    face: json["face"],
    fans: json["fans"],
    favorite: json["favorite"],
    like: json["like"],
    coin: json["coin"],
    browsing: json["browsing"],
    bannerList: List<BannerModel>.from(json["bannerList"].map((x) => BannerModel.fromJson(x))),
    courseList: List<Course>.from(json["courseList"].map((x) => Course.fromJson(x))),
    benefitList: List<Benefit>.from(json["benefitList"].map((x) => Benefit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "face": face,
    "fans": fans,
    "favorite": favorite,
    "like": like,
    "coin": coin,
    "browsing": browsing,
    "bannerList": List<dynamic>.from(bannerList.map((x) => x.toJson())),
    "courseList": List<dynamic>.from(courseList.map((x) => x.toJson())),
    "benefitList": List<dynamic>.from(benefitList.map((x) => x.toJson())),
  };
}


class Benefit {
  Benefit({
    this.name,
    this.url,
  });

  String name;
  String url;

  factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

class Course {
  Course({
    this.name,
    this.cover,
    this.url,
    this.group,
  });

  String name;
  String cover;
  String url;
  int group;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    name: json["name"],
    cover: json["cover"],
    url: json["url"],
    group: json["group"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "cover": cover,
    "url": url,
    "group": group,
  };
}
