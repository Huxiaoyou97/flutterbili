

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
  DateTime createTime;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json["id"],
    sticky: json["sticky"],
    type: json["type"],
    title: json["title"],
    subtitle: json["subtitle"],
    url: json["url"],
    cover: json["cover"],
    createTime: DateTime.parse(json["createTime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sticky": sticky,
    "type": type,
    "title": title,
    "subtitle": subtitle,
    "url": url,
    "cover": cover,
    "createTime": createTime.toIso8601String(),
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

class VideoModel {
  VideoModel({
    this.id,
    this.vid,
    this.title,
    this.tname,
    this.url,
    this.cover,
    this.pubdate,
    this.desc,
    this.view,
    this.duration,
    this.owner,
    this.reply,
    this.favorite,
    this.like,
    this.coin,
    this.share,
    this.createTime,
    this.size,
  });

  String id;
  String vid;
  String title;
  String tname;
  String url;
  String cover;
  int pubdate;
  String desc;
  int view;
  int duration;
  Owner owner;
  int reply;
  int favorite;
  int like;
  int coin;
  int share;
  DateTime createTime;
  int size;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    id: json["id"],
    vid: json["vid"],
    title: json["title"],
    tname: json["tname"],
    url: json["url"],
    cover: json["cover"],
    pubdate: json["pubdate"],
    desc: json["desc"],
    view: json["view"],
    duration: json["duration"],
    owner: Owner.fromJson(json["owner"]),
    reply: json["reply"],
    favorite: json["favorite"],
    like: json["like"],
    coin: json["coin"],
    share: json["share"],
    createTime: DateTime.parse(json["createTime"]),
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vid": vid,
    "title": title,
    "tname": tname,
    "url": url,
    "cover": cover,
    "pubdate": pubdate,
    "desc": desc,
    "view": view,
    "duration": duration,
    "owner": owner.toJson(),
    "reply": reply,
    "favorite": favorite,
    "like": like,
    "coin": coin,
    "share": share,
    "createTime": createTime.toIso8601String(),
    "size": size,
  };
}

class Owner {
  Owner({
    this.name,
    this.face,
    this.fans,
  });

  String name;
  String face;
  int fans;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    name: json["name"],
    face: json["face"],
    fans: json["fans"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "face": face,
    "fans": fans,
  };
}
